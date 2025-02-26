! $Id$
!
! Earth System Modeling Framework
! Copyright (c) 2002-2025, University Corporation for Atmospheric Research,
! Massachusetts Institute of Technology, Geophysical Fluid Dynamics
! Laboratory, University of Michigan, National Centers for Environmental
! Prediction, Los Alamos National Laboratory, Argonne National Laboratory,
! NASA Goddard Space Flight Center.
! Licensed under the University of Illinois-NCSA License.
!
#define ESMF_FILENAME "ESMF_UtilCubedSphere.F90"

module ESMF_UtilCubedSphereMod

  ! !USES:
  use ESMF_UtilTypesMod     ! ESMF utility types
  use ESMF_InitMacrosMod    ! ESMF initializer macros
  implicit none
  private

!------------------------------------------------------------------------------
! ! ESMF_CubedSphereTransform_Args
!
!------------------------------------------------------------------------------
  type ESMF_CubedSphereTransform_Args
! private
    real(ESMF_KIND_R8) :: stretch_factor, target_lat, target_lon
  end type

  real(ESMF_KIND_R8) :: csFac = -999
  real(ESMF_KIND_R8),  parameter:: pi = 3.14159265358979323846_ESMF_KIND_R8
  real(ESMF_KIND_R8),  parameter:: radius = 6371.0
  real(ESMF_KIND_R8)            :: zeta = 1.0                ! non-linear flag 
  real(ESMF_KIND_R8) , parameter:: todeg = 180.0/pi          ! convert to degrees
  real(ESMF_KIND_R8) , parameter:: torad = pi/180.0          ! convert to radians
  real(ESMF_KIND_R8) , parameter:: missing = 1.e25
  real(ESMF_KIND_R8),  parameter :: JAPAN_SHIFT = pi/18
  integer, parameter:: f_p = maxval(selected_real_kind(15),selected_real_kind(20))
  real(ESMF_KIND_R8)    :: stretch               ! Optional stretching factor for the grid 
  logical :: dxdy_area = .false.   ! define area using dx*dy else spherical excess formula
  logical :: latlon = .false.
  logical :: cubed_sphere = .false.
  logical :: double_periodic = .false.
  logical :: latlon_patch = .false.
  logical :: latlon_strip = .false.
  logical :: channel = .false.
  logical :: have_south_pole = .false.
  logical :: have_north_pole = .false.
  logical :: uniform_ppm = .true.     ! assume uniform grid spacing for PPM calcs, else variable dx,dy
  integer :: interpOrder = 1
  logical :: debug_message_size = .false.
  logical :: write_grid_char_file = .false.
  logical :: stretched_grid = .false.
  logical :: is_grid_created = .false.

  ! grid descriptors

  ! Horizontal
  integer :: npx_g, npy_g, npz_g, ntiles_g ! global domain
#ifndef NO_GRID_G
  real(ESMF_KIND_R8), allocatable, target, dimension(:,:,:) :: grid_g
#endif
  real(ESMF_KIND_R8), allocatable, target, dimension(:,:,:) :: grid, agrid
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: area, area_c
  real(ESMF_KIND_R8), allocatable, dimension(:,:,:) :: e1,e2
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: dx, dy
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: dxc, dyc
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: dxa, dya
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: rarea, rarea_c
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: rdx, rdy
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: rdxc, rdyc
  real(ESMF_KIND_R8), allocatable, dimension(:,:) :: rdxa, rdya
  real(ESMF_KIND_R8)  :: acapN, acapS
  real(ESMF_KIND_R8)  :: globalarea  ! total Global Area
  real(ESMF_KIND_R8), allocatable :: cose(:,:)
  real(ESMF_KIND_R8), allocatable :: cosp(:,:)
  real(ESMF_KIND_R8), allocatable :: acosp(:,:)
  
  integer, dimension(:,:,:), allocatable :: iinta, jinta, iintb, jintb
  
  integer :: grid_type = 0    ! -1: read from file; 0: ED Gnomonic
                              !  0: the "true" equal-distance Gnomonic grid
                              !  1: the traditional equal-distance Gnomonic grid
                              !  2: the equal-angular Gnomonic grid
                              !  3: the lat-lon grid -- to be implemented
                              !  4: double periodic boundary condition on Cartesian grid
                              !  5: latlon patch
                              !  6: latlon strip (cyclic in longitude)
                              !  7: channel flow on Cartesian grid

  real(ESMF_KIND_R8) :: dx_const = 1000.    ! spatial resolution for double periodic boundary configuration [m]
  real(ESMF_KIND_R8) :: dy_const = 1000.
  real(ESMF_KIND_R8) :: deglon_start = -30., deglon_stop = 30., &  ! boundaries of latlon patch
          deglat_start = -30., deglat_stop = 30.

  public :: ESMF_CubedSphereTransform_Args
  public :: ESMF_UtilCreateCSCoords
  public :: ESMF_UtilCreateCSCoordsPar

contains

! routine to create the global edges and centers of the cubed-sphere grid
! but not the ESMF grid
subroutine ESMF_UtilCreateCSCoords(npts, LonEdge,LatEdge, start, count, tile, &
  LonCenter, LatCenter, schmidtTransform)

! !ARGUMENTS:
    integer,           intent(IN)     :: npts
!    integer,           intent(in)     :: petNo
    real(ESMF_KIND_R8), optional, intent(inout) :: LonEdge(:,:)
    real(ESMF_KIND_R8), optional, intent(inout) :: LatEdge(:,:)
    integer, optional, intent(in)     :: start(:)
    integer, optional, intent(in)     :: count(:)
    integer, optional, intent(in)     :: tile
    real(ESMF_KIND_R8), optional, intent(inout) :: LonCenter(:,:)
    real(ESMF_KIND_R8), optional, intent(inout) :: LatCenter(:,:)
    type(ESMF_CubedSphereTransform_Args), optional, intent(in)    :: schmidtTransform

! ErrLog variables
!-----------------

 integer                      :: STATUS

! Local variables
!-----------------
  integer, parameter            :: grid_type = 0
  integer                       :: ntiles=6
  integer                       :: ndims=2
  integer                       :: I, J, N
  integer                       :: IG, JG
  real(ESMF_KIND_R8)                          :: alocs(2)
  real(ESMF_KIND_R8), allocatable             :: tile1(:,:,:)
  integer                       :: rc
  real(ESMF_KIND_R8), allocatable             :: tile_local(:,:,:)
  real(ESMF_KIND_R8), allocatable, save       :: grid_global(:,:,:,:)

  if (allocated(grid_global)) then 
     if (size(grid_global,1) /= npts+1) then
        deallocate(grid_global)
     endif
  endif   
  if (.not. allocated(grid_global)) then
     allocate( grid_global(npts+1,npts+1,ndims,ntiles) )
     call gnomonic_grids(grid_type, npts, grid_global(:,:,1,1), grid_global(:,:,2,1))
     ! mirror_grid assumes that the tile=1 is centered on equator and greenwich meridian Lon[-pi,pi]
     call mirror_grid(grid_global, 0, npts+1, npts+1, 2, 6)
     do n=1,ntiles
        do j=1,npts+1
           do i=1,npts+1
!---------------------------------
! Shift the corner away from Japan
!---------------------------------
! This will result in the corner close to east coast of China
             if (.not.present(schmidtTransform)) grid_global(i,j,1,n) = grid_global(i,j,1,n) - JAPAN_SHIFT
             if ( grid_global(i,j,1,n) < 0. )              &
                grid_global(i,j,1,n) = grid_global(i,j,1,n) + 2.*pi
             if (ABS(grid_global(i,j,1,n)) < 1.e-10) grid_global(i,j,1,n) = 0.0
             if (ABS(grid_global(i,j,2,n)) < 1.e-10) grid_global(i,j,2,n) = 0.0
          enddo
       enddo
    enddo
    !---------------------------------
    ! Clean Up Corners
    !---------------------------------
    grid_global(  1,1:npts+1,:,2)=grid_global(npts+1,1:npts+1,:,1)
    grid_global(  1,1:npts+1,:,3)=grid_global(npts+1:1:-1,npts+1,:,1)
    grid_global(1:npts+1,npts+1,:,5)=grid_global(1,npts+1:1:-1,:,1)
    grid_global(1:npts+1,npts+1,:,6)=grid_global(1:npts+1,1,:,1)
    grid_global(1:npts+1,  1,:,3)=grid_global(1:npts+1,npts+1,:,2)
    grid_global(1:npts+1,  1,:,4)=grid_global(npts+1,npts+1:1:-1,:,2)
    grid_global(npts+1,1:npts+1,:,6)=grid_global(npts+1:1:-1,1,:,2)
    grid_global(  1,1:npts+1,:,4)=grid_global(npts+1,1:npts+1,:,3)
    grid_global(  1,1:npts+1,:,5)=grid_global(npts+1:1:-1,npts+1,:,3)
    !!!grid_global(npts+1,1:npts+1,:,3)=grid_global(1,1:npts+1,:,4)
    grid_global(1:npts+1,  1,:,5)=grid_global(1:npts+1,npts+1,:,4)
    grid_global(1:npts+1,  1,:,6)=grid_global(npts+1,npts+1:1:-1,:,4)
    grid_global(  1,1:npts+1,:,6)=grid_global(npts+1,1:npts+1,:,5)
  endif

#if 0
  ! check if they are identical
  if (PetNo == 0) then
  do n=1,npts+1
    do j=1,2
    if (grid_global(1,n,j,2) /= grid_global(npts+1,n,j,1)) then
       print *, "mismatch tile 1&2", n, grid_global(1,n,j,2),grid_global(npts+1,n,j,1)
    endif
    if (grid_global(1,n,j,3) /= grid_global(npts+2-n,npts+1,j,1)) then
       print *, "mismatch tile 1&3", n, grid_global(1,n,j,3),grid_global(npts+2-n,npts+1,j,1)
    endif
    if (grid_global(n,npts+1,j,5) /= grid_global(1,npts+2-n,j,1)) then
       print *, "mismatch tile 1&5", n, grid_global(n,npts+1,j,5),grid_global(1,npts+2-n,j,1)
    endif
    if (grid_global(n,npts+1,j,6) /= grid_global(n,1,j,1)) then
       print *, "mismatch tile 1&6", n, grid_global(n,npts+1,j,6),grid_global(n,1,j,1)
    endif
    if (grid_global(n,1,j,3) /= grid_global(n,npts+1,j,2)) then
       print *, "mismatch tile 2&3", n, grid_global(n,1,j,3),grid_global(n,npts+1,j,2)
    endif
    if (grid_global(n,1,j,4) /= grid_global(npts+1,npts+2-n,j,2)) then
       print *, "mismatch tile 2&4", n, grid_global(n,1,j,4),grid_global(npts+1,npts+2-n,j,2)
    endif
    if (grid_global(npts+1,n,j,6) /= grid_global(npts+2-n,1,j,2)) then
       print *, "mismatch tile 2&6", n, grid_global(npts+1,n,j,6),grid_global(npts+2-n,1,j,2)
    endif
    if (grid_global(1,n,j,4) /= grid_global(npts+1,n,j,3)) then
       print *, "mismatch tile 3&4", n, grid_global(i,n,j,4),grid_global(npts+1,n,j,3)
    endif
    if (grid_global(1,n,j,5) /= grid_global(npts+2-n,npts+1,j,3)) then
       print *, "mismatch tile 5&3", n, grid_global(1,n,j,5),grid_global(npts+2-n,npts+1,j,3)
    endif
    if (grid_global(n,1,j,5) /= grid_global(n,npts+1,j,4)) then
       print *, "mismatch tile 5&4", n, grid_global(n,1,j,5),grid_global(n,npts+1,j,4)
    endif
    if (grid_global(n,1,j,6) /= grid_global(npts+1,npts+2-n,j,4)) then
       print *, "mismatch tile 6&4", n, grid_global(n,1,j,6),grid_global(npts+1,npts+2-n,j,4)
    endif
    if (grid_global(1,n,j,6) /= grid_global(npts+1,n,j,5)) then
       print *, "mismatch tile 1&2", n, grid_global(1,n,j,6),grid_global(npts+1,n,j,5)
    endif
  enddo
  enddo
  endif
#endif

  if (present(schmidtTransform)) then
     do n=1,ntiles
       call direct_transform(schmidtTransform%stretch_factor,schmidtTransform%target_lon,&
          schmidtTransform%target_lat,grid_global(:,:,1,n),grid_global(:,:,2,n))
     enddo
  end if

  if (present(LonEdge) .and. present(LatEdge)) then
    do n=1,ntiles
       do j=1,npts+1
          do i=1,npts+1
            jg=(n-1)*(npts+1)+j
            LonEdge(i,jg) = grid_global(i,j,1,n)
            LatEdge(i,jg) = grid_global(i,j,2,n)
          enddo
       enddo
    enddo
  endif
 
  if (present(LonCenter) .and. present(LatCenter)) then
    if (present(start) .and. present(count) .and. present(tile)) then
        n=tile
        do j=start(2), start(2)+count(2)-1
           do i=start(1),start(1)+count(1)-1
              call cell_center2(grid_global(i,j,  1,n), grid_global(i,j,  2,n),   &
                                grid_global(i+1,j,1,n), grid_global(i+1,j,2,n),   &
                                grid_global(i,j+1,1,n), grid_global(i,j+1,2,n),   &
                                grid_global(i+1,j+1,1,n), grid_global(i+1,j+1,2,n),   &
                                alocs)
              LonCenter(i-start(1)+1,j-start(2)+1) = alocs(1)
              LatCenter(i-start(1)+1,j-start(2)+1) = alocs(2)
           enddo
        enddo
     else
        do n=1,ntiles
           do j=1,npts
              do i=1,npts
              call cell_center2(grid_global(i,j,  1,n), grid_global(i,j,  2,n),   &
                                grid_global(i+1,j,1,n), grid_global(i+1,j,2,n),   &
                                grid_global(i,j+1,1,n), grid_global(i,j+1,2,n),   &
                                grid_global(i+1,j+1,1,n), grid_global(i+1,j+1,2,n),   &
                                alocs)
                  jg = (n-1)*npts + j
                  LonCenter(i,jg) = alocs(1)
                  LatCenter(i,jg) = alocs(2)
              enddo
           enddo
        enddo
     end if
  end if
  deallocate( grid_global )

  return

end subroutine ESMF_UtilCreateCSCoords


subroutine ESMF_UtilCreateCSCoordsPar(npts, LonEdge,LatEdge, start, count, tile, &
     LonCenter, LatCenter, schmidtTransform, local_algorithm)

! !ARGUMENTS:
    integer,           intent(IN)     :: npts
    real(ESMF_KIND_R8), optional, intent(inout) :: LonEdge(:,:)
    real(ESMF_KIND_R8), optional, intent(inout) :: LatEdge(:,:)
    integer, optional, intent(in)     :: start(:)
    integer, optional, intent(in)     :: count(:)
    integer, optional, intent(in)     :: tile
    real(ESMF_KIND_R8), optional, intent(inout) :: LonCenter(:,:)
    real(ESMF_KIND_R8), optional, intent(inout) :: LatCenter(:,:)
    type(ESMF_CubedSphereTransform_Args), optional, intent(in) :: schmidtTransform
    logical, optional, intent(in) :: local_algorithm

 integer                      :: STATUS

! Local variables
!-----------------
  integer, parameter            :: grid_type = 0
  integer                       :: ntiles=6
  integer                       :: ndims=2
  integer                       :: I, J, N
  integer                       :: IG, JG
  real(ESMF_KIND_R8)                          :: alocs(2)
  real(ESMF_KIND_R8), allocatable             :: tile1(:,:,:)
  integer                       :: rc
  real(ESMF_KIND_R8), allocatable             :: tile_local(:,:,:)
  real(ESMF_KIND_R8), allocatable, save       :: global_tile1(:,:,:)
  integer                       :: shapLon(2), shapLat(2)
  logical :: local_algorithm_

  local_algorithm_ = .false.
  if (present(local_algorithm)) local_algorithm_ = local_algorithm

  allocate(tile_local(count(1)+1,count(2)+1,ndims) )

  if (local_algorithm_) then
     call get_gnomonic_local_coords(grid_type, npts, start, tile_local(:,:,1), tile_local(:,:,2))
     call mirror_grid_local_new(tile_local, tile)
  else ! legacy algorithm using global sized tile
     allocate(global_tile1(npts+1,npts+1,ndims))
     call gnomonic_grids(grid_type, npts, global_tile1(:,:,1), global_tile1(:,:,2))
     call mirror_grid_local(tile_local, global_tile1, start, count, 2, tile)
     deallocate(global_tile1)
  end if

    ! mirror_grid assumes that the tile=1 is centered on equator and greenwich meridian Lon[-pi,pi]

!---------------------------------
! Shift the corner away from Japan for global tile #1
!---------------------------------
! This will result in the corner close to east coast of China

    ! fix the values in the local tile
    do j=1,count(2)+1
       do i=1,count(1)+1
           if (.not.present(schmidtTransform)) tile_local(i,j,1) = tile_local(i,j,1) - JAPAN_SHIFT
           if ( tile_local(i,j,1) < 0. )              &
                tile_local(i,j,1) = tile_local(i,j,1) + 2.*pi
           if (ABS(tile_local(i,j,1)) < 1.e-10) tile_local(i,j,1) = 0.0
           if (ABS(tile_local(i,j,2)) < 1.e-10) tile_local(i,j,2) = 0.0
       enddo
    enddo

    if (present(schmidtTransform)) then
     call direct_transform(schmidtTransform%stretch_factor,schmidtTransform%target_lon,&
          schmidtTransform%target_lat,tile_local(:,:,1),tile_local(:,:,2))
    end if
    
    if (present(LonEdge) .and. present(LatEdge)) then
       shapLon=shape(LonEdge)
       shapLat=shape(LatEdge)
       LonEdge=tile_local(1:shapLon(1),1:shapLon(2),1)
       LatEdge=tile_local(1:shapLat(1),1:shapLat(2),2)
    endif


    if (present(LonCenter) .and. present(LatCenter)) then
        do j=1, count(2)
           do i=1,count(1)
              call cell_center2(tile_local(i,j,  1), tile_local(i,j,    2),   &
                                tile_local(i+1,j,1), tile_local(i+1,j,  2),   &
                                tile_local(i,j+1,1), tile_local(i,j+1,  2),   &
                                tile_local(i+1,j+1,1), tile_local(i+1,j+1,2),   &
                                alocs)
              LonCenter(i,j) = alocs(1)
              LatCenter(i,j) = alocs(2)
           enddo
        enddo
     end if

     deallocate(tile_local)

     return

  end subroutine ESMF_UtilCreateCSCoordsPar


  !#################################################################################
  ! Routines for computing legacy coordinates
  ! These are less accurate and use far more memory.

 subroutine gnomonic_grids(grid_type, im, lon, lat)
 integer, intent(in):: im, grid_type
 real(ESMF_KIND_R8), intent(out):: lon(im+1,im+1)
 real(ESMF_KIND_R8), intent(out):: lat(im+1,im+1)
 integer i, j

  if(grid_type==0) call gnomonic_ed(  im, lon, lat)
  if(grid_type==1) call gnomonic_dist(im, lon, lat)
  if(grid_type==2) call gnomonic_angl(im, lon, lat)


  if(grid_type<3) then
     call symm_ed(im, lon, lat)
     do j=1,im+1
        do i=1,im+1
           lon(i,j) = lon(i,j) - pi
        enddo
     enddo
!    call van2_init(lon, lat, im+1, im+1)
  endif

!   gnomonic_grid = .true.
  
 end subroutine gnomonic_grids

 
 subroutine gnomonic_ed(im, lamda, theta)
!-----------------------------------------------------
! Equal distance along the 4 edges of the cubed sphere
!-----------------------------------------------------
! Properties: 
!            * defined by intersections of great circles
!            * max(dx,dy; global) / min(dx,dy; global) = sqrt(2) = 1.4142
!            * Max(aspect ratio) = 1.06089
!            * the N-S coordinate curves are const longitude on the 4 faces with equator 
! For C2000: (dx_min, dx_max) = (3.921, 5.545)    in km unit
! This is the grid of choice for global cloud resolving

 integer, intent(in):: im
 real(ESMF_KIND_R8), intent(out):: lamda(im+1,im+1)
 real(ESMF_KIND_R8), intent(out):: theta(im+1,im+1)

! Local:
 real(ESMF_KIND_R8) pp(3,im+1,im+1)
 real(ESMF_KIND_R8) p1(2), p2(2)
 real(ESMF_KIND_R8):: rsq3, alpha, delx, dely
 integer i, j, k

  rsq3 = 1./sqrt(3.) 
 alpha = asin( rsq3 )

! Ranges:
! lamda = [0.75*pi, 1.25*pi]
! theta = [-alpha, alpha]

    dely = 2.*alpha / real(im,ESMF_KIND_R8)

! Define East-West edges:
 do j=1,im+1
    lamda(1,   j) = 0.75*pi                               ! West edge
    lamda(im+1,j) = 1.25*pi                               ! East edge
    theta(1,   j) = -alpha + dely*real(j-1,ESMF_KIND_R8)  ! West edge
    theta(im+1,j) = theta(1,j)                            ! East edge
 enddo

! Get North-South edges by symmetry:

 do i=2,im
    call mirror_latlon(lamda(1,1), theta(1,1), lamda(im+1,im+1), theta(im+1,im+1), &
                       lamda(1,i), theta(1,i), lamda(i,1),       theta(i,      1) )
    lamda(i,im+1) =  lamda(i,1)
    theta(i,im+1) = -theta(i,1)
 enddo

! Set 4 corners:
    call latlon2xyz2(lamda(1    ,  1), theta(1,      1), pp(1,   1,   1))
    call latlon2xyz2(lamda(im+1,   1), theta(im+1,   1), pp(1,im+1,   1))
    call latlon2xyz2(lamda(1,   im+1), theta(1,   im+1), pp(1,   1,im+1))
    call latlon2xyz2(lamda(im+1,im+1), theta(im+1,im+1), pp(1,im+1,im+1))

! Map edges on the sphere back to cube:
! Intersections at x=-rsq3

 i=1
 do j=2,im
    call latlon2xyz2(lamda(i,j), theta(i,j), pp(1,i,j))
    pp(2,i,j) = -pp(2,i,j)*rsq3/pp(1,i,j)
    pp(3,i,j) = -pp(3,i,j)*rsq3/pp(1,i,j)
 enddo

 j=1
 do i=2,im
    call latlon2xyz2(lamda(i,j), theta(i,j), pp(1,i,1))
    pp(2,i,1) = -pp(2,i,1)*rsq3/pp(1,i,1)
    pp(3,i,1) = -pp(3,i,1)*rsq3/pp(1,i,1)
 enddo

 do j=1,im+1
    do i=1,im+1
       pp(1,i,j) = -rsq3
    enddo
 enddo

 do j=2,im+1
    do i=2,im+1
! Copy y-z face of the cube along j=1
       pp(2,i,j) = pp(2,i,1)
! Copy along i=1
       pp(3,i,j) = pp(3,1,j)
    enddo
 enddo

 call cart_to_latlon( (im+1)*(im+1), pp, lamda, theta)

 end subroutine gnomonic_ed

  subroutine gnomonic_angl(im, lamda, theta)
! This is the commonly known equi-angular grid
 integer im
 real(ESMF_KIND_R8) lamda(im+1,im+1)
 real(ESMF_KIND_R8) theta(im+1,im+1)
 real(ESMF_KIND_R8) p(3,im+1,im+1)
! Local
 real(ESMF_KIND_R8) rsq3, xf, y0, z0, y, x, z, ds
 real(ESMF_KIND_R8) dy, dz
 integer j,k
 real(ESMF_KIND_R8) dp

 dp = 0.5*pi/real(im,ESMF_KIND_R8)

 rsq3 = 1./sqrt(3.) 
 do k=1,im+1
    do j=1,im+1
       p(1,j,k) =-rsq3               ! constant
       p(2,j,k) =-rsq3*tan(-0.25*pi+(j-1)*dp)
       p(3,j,k) = rsq3*tan(-0.25*pi+(k-1)*dp)
    enddo
 enddo

 call cart_to_latlon( (im+1)*(im+1), p, lamda, theta)

 end subroutine gnomonic_angl

 

 subroutine gnomonic_dist(im, lamda, theta)
! This is the commonly known equi-distance grid
 integer im
 real(ESMF_KIND_R8) lamda(im+1,im+1)
 real(ESMF_KIND_R8) theta(im+1,im+1)
 real(ESMF_KIND_R8) p(3,im+1,im+1)
! Local
 real(ESMF_KIND_R8) rsq3, xf, y0, z0, y, x, z, ds
 real(ESMF_KIND_R8) dy, dz
 integer j,k

! Face-2

 rsq3 = 1./sqrt(3.) 
 xf = -rsq3
 y0 =  rsq3;  dy = -2.*rsq3/im 
 z0 = -rsq3;  dz =  2.*rsq3/im

 do k=1,im+1
    do j=1,im+1
       p(1,j,k) = xf
       p(2,j,k) = y0 + (j-1)*dy
       p(3,j,k) = z0 + (k-1)*dz
    enddo
 enddo
 call cart_to_latlon( (im+1)*(im+1), p, lamda, theta)

 end subroutine gnomonic_dist


  subroutine mirror_grid_local(local_tile,global_tile1,start,count,ndims,tileno)
         real(ESMF_KIND_R8)   , intent(INOUT) :: local_tile(:,:,:)
         real(ESMF_KIND_R8)   , intent(INOUT)    :: global_tile1(:,:,:)      
         integer, intent(IN)    :: start(2), count(2)
         integer, intent(IN)    :: ndims, tileno

         integer :: i,j,n,n1,n2,nreg, npx, npy
         integer :: ii, jj
         real(ESMF_KIND_R8) :: x1,y1,z1, x2,y2,z2, ang
!
!    Mirror Across the 0-longitude
!
      
         npx = size(global_tile1,1)
         npy = size(global_tile1,2)
         do j=1,ceiling(npy/2.)
            do i=1,ceiling(npx/2.)

            x1 = 0.25 * (ABS(global_tile1(i        ,j        ,1)) + &
                         ABS(global_tile1(npx-(i-1),j        ,1)) + &
                         ABS(global_tile1(i        ,npy-(j-1),1)) + &
                         ABS(global_tile1(npx-(i-1),npy-(j-1),1)))
            global_tile1(i        ,j        ,1) = SIGN(x1,global_tile1(i        ,j        ,1))
            global_tile1(npx-(i-1),j        ,1) = SIGN(x1,global_tile1(npx-(i-1),j        ,1))
            global_tile1(i        ,npy-(j-1),1) = SIGN(x1,global_tile1(i        ,npy-(j-1),1))
            global_tile1(npx-(i-1),npy-(j-1),1) = SIGN(x1,global_tile1(npx-(i-1),npy-(j-1),1))

            y1 = 0.25 * (ABS(global_tile1(i        ,j        ,2)) + &   
                         ABS(global_tile1(npx-(i-1),j        ,2)) + &
                         ABS(global_tile1(i        ,npy-(j-1),2)) + &
                         ABS(global_tile1(npx-(i-1),npy-(j-1),2)))
            global_tile1(i        ,j        ,2) = SIGN(y1,global_tile1(i        ,j        ,2))
            global_tile1(npx-(i-1),j        ,2) = SIGN(y1,global_tile1(npx-(i-1),j        ,2))
            global_tile1(i        ,npy-(j-1),2) = SIGN(y1,global_tile1(i        ,npy-(j-1),2))
            global_tile1(npx-(i-1),npy-(j-1),2) = SIGN(y1,global_tile1(npx-(i-1),npy-(j-1),2))
             
           ! force dateline/greenwich-meridion consitency
            if (mod(npx,2) /= 0) then
              if ( (i==1+(npx-1)/2.0) ) then
                 global_tile1(i,j        ,1) = 0.0
                 global_tile1(i,npy-(j-1),1) = 0.0
              endif
            endif

            enddo
         enddo

         if (tileno == 1) then
            local_tile=global_tile1(start(1):start(1)+count(1), start(2):start(2)+count(2),:)
         else
           do j=start(2),start(2)+count(2)
             do i=start(1),start(1)+count(1)

               x1 = global_tile1(i,j,1)
               y1 = global_tile1(i,j,2)
               z1 = radius

               if (tileno == 2) then
                  ang = -90.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
               elseif (tileno == 3) then
                  ang = -90.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
                  ang = 90.
                  call rot_3d( 1, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the x-axis
                  x2=x1
                  y2=y1
                  z2=z1

           ! force North Pole and dateline/greenwich-meridion consitency
                  if (mod(npx,2) /= 0) then
                     if ( (i==1+(npx-1)/2.0) .and. (i==j) ) then
                        x2 = 0.0
                        y2 = pi/2.0
                     endif
                     if ( (j==1+(npy-1)/2.0) .and. (i < 1+(npx-1)/2.0) ) then
                        x2 = 0.0
                     endif
                     if ( (j==1+(npy-1)/2.0) .and. (i > 1+(npx-1)/2.0) ) then
                        x2 = pi
                     endif
                  endif

               elseif (tileno == 4) then
                  ang = -180.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
                  ang = 90.
                  call rot_3d( 1, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the x-axis
                  x2=x1
                  y2=y1
                  z2=z1

               ! force dateline/greenwich-meridion consitency
                  if (mod(npx,2) /= 0) then
                    if ( (j==1+(npy-1)/2.0) ) then
                       x2 = pi
                    endif
                  endif

               elseif (tileno == 5) then
                  ang = 90.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
                  ang = 90.
                  call rot_3d( 2, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the y-axis
                  x2=x1
                  y2=y1
                  z2=z1
               elseif (tileno == 6) then
                  ang = 90.
                  call rot_3d( 2, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the y-axis
                  ang = 0.
                  call rot_3d( 3, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the z-axis
                  x2=x1
                  y2=y1
                  z2=z1

           ! force South Pole and dateline/greenwich-meridion consitency
                  if (mod(npx,2) /= 0) then
                     if ( (i==1+(npx-1)/2.0) .and. (i==j) ) then
                        x2 = 0.0
                        y2 = -pi/2.0
                     endif
                     if ( (i==1+(npx-1)/2.0) .and. (j > 1+(npy-1)/2.0) ) then
                        x2 = 0.0
                     endif
                     if ( (i==1+(npx-1)/2.0) .and. (j < 1+(npy-1)/2.0) ) then
                        x2 = pi
                     endif
                  endif

               endif

               ii=i-start(1)+1
               jj=j-start(2)+1
               local_tile(ii,jj,1) = x2
               local_tile(ii,jj,2) = y2

              enddo
            enddo
       endif
  end subroutine mirror_grid_local


 
 subroutine symm_ed(im, lamda, theta)
! Make grid symmetrical to i=im/2+1
 integer im
 real(ESMF_KIND_R8) lamda(im+1,im+1)
 real(ESMF_KIND_R8) theta(im+1,im+1)
 integer i,j,ip,jp
 real(ESMF_KIND_R8) avg

 do j=2,im+1
    do i=2,im
       lamda(i,j) = lamda(i,1)
    enddo
 enddo

 do j=1,im+1
    do i=1,im/2
       ip = im + 2 - i
       avg = 0.5*(lamda(i,j)-lamda(ip,j))
       lamda(i, j) = avg + pi
       lamda(ip,j) = pi - avg 
       avg = 0.5*(theta(i,j)+theta(ip,j))
       theta(i, j) = avg
       theta(ip,j) = avg
    enddo
 enddo

! Make grid symmetrical to j=im/2+1
 do j=1,im/2
       jp = im + 2 - j
    do i=2,im
       avg = 0.5*(lamda(i,j)+lamda(i,jp))
       lamda(i, j) = avg
       lamda(i,jp) = avg
       avg = 0.5*(theta(i,j)-theta(i,jp))
       theta(i, j) =  avg
       theta(i,jp) = -avg
    enddo
 enddo

 end subroutine symm_ed

 real(ESMF_KIND_R8) function great_circle_dist( q1, q2, radius )
      real(ESMF_KIND_R8), intent(IN)           :: q1(2), q2(2)
      real(ESMF_KIND_R8), intent(IN), optional :: radius
 
      real(ESMF_KIND_R8) :: p1(2), p2(2)
      real(ESMF_KIND_R8) :: beta
      integer n

      do n=1,2
         p1(n) = q1(n)
         p2(n) = q2(n)
      enddo

      beta = asin( sqrt( sin((p1(2)-p2(2))/2.)**2 + cos(p1(2))*cos(p2(2))*   &
                         sin((p1(1)-p2(1))/2.)**2 ) ) * 2.

      if ( present(radius) ) then
           great_circle_dist = radius * beta
      else
           great_circle_dist = beta   ! Returns the angle
      endif

  end function great_circle_dist

!-------------------------------------------------------------------------------
! vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv !
!
!     rot_3d :: rotate points on a sphere in xyz coords (convert angle from
!               degrees to radians if necessary)
!
      subroutine rot_3d(axis, x1in, y1in, z1in, angle, x2out, y2out, z2out, degrees, convert)

         integer, intent(IN) :: axis         ! axis of rotation 1=x, 2=y, 3=z
         real(ESMF_KIND_R8) , intent(IN)    :: x1in, y1in, z1in
         real(ESMF_KIND_R8) , intent(INOUT) :: angle        ! angle to rotate in radians
         real(ESMF_KIND_R8) , intent(OUT)   :: x2out, y2out, z2out
         integer, intent(IN), optional :: degrees ! if present convert angle 
                                                  ! from degrees to radians
         integer, intent(IN), optional :: convert ! if present convert input point
                                                  ! from spherical to cartesian, rotate, 
                                                  ! and convert back

         real(ESMF_KIND_R8)  :: c, s
         real(ESMF_KIND_R8)  :: x1,y1,z1, x2,y2,z2

         if ( present(convert) ) then
           call spherical_to_cartesian(x1in, y1in, z1in, x1, y1, z1)
         else
           x1=x1in
           y1=y1in
           z1=z1in
         endif

         if ( present(degrees) ) then
            angle = angle*torad
         endif

         c = COS(angle)
         s = SIN(angle)

         SELECT CASE(axis)
             
            CASE(1)
               x2 =  x1
               y2 =  c*y1 + s*z1
               z2 = -s*y1 + c*z1
            CASE(2)
               x2 = c*x1 - s*z1
               y2 = y1
               z2 = s*x1 + c*z1
            CASE(3)
               x2 =  c*x1 + s*y1
               y2 = -s*x1 + c*y1
               z2 = z1
            CASE DEFAULT
              write(*,*) "Invalid axis: must be 1 for X, 2 for Y, 3 for Z."
 
         END SELECT

         if ( present(convert) ) then
           call cartesian_to_spherical(x2, y2, z2, x2out, y2out, z2out)
         else
           x2out=x2
           y2out=y2
           z2out=z2
         endif

      end subroutine rot_3d

      subroutine cartesian_to_spherical(x, y, z, lon, lat, r) 
      real(ESMF_KIND_R8) , intent(IN)  :: x, y, z
      real(ESMF_KIND_R8) , intent(OUT) :: lon, lat, r

      r = SQRT(x*x + y*y + z*z)
      if ( (abs(x) + abs(y)) < 1.E-10 ) then       ! poles:
           lon = 0.
      else
           lon = ATAN2(y,x)    ! range: [-pi,pi]
      endif 

#ifdef RIGHT_HAND
      lat = asin(z/r)
#else
      lat = ACOS(z/r) - pi/2.
#endif

      end subroutine cartesian_to_spherical
 

!-------------------------------------------------------------------------------
! vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv !
!
!     spherical_to_cartesian :: convert from spheircal coordinates to xyz coords
! 
      subroutine spherical_to_cartesian(lon, lat, r, x, y, z)

         real(ESMF_KIND_R8) , intent(IN)  :: lon, lat, r
         real(ESMF_KIND_R8) , intent(OUT) :: x, y, z

         x = r * COS(lon) * cos(lat)
         y = r * SIN(lon) * cos(lat)

#ifdef RIGHT_HAND
         z =  r * SIN(lat)
#else
         z = -r * sin(lat)
#endif

      end subroutine spherical_to_cartesian



 subroutine latlon2xyz2(lon, lat, p3)
 real(ESMF_KIND_R8), intent(in):: lon, lat
 real(ESMF_KIND_R8), intent(out):: p3(3)
 real(ESMF_KIND_R8) e(2)

    e(1) = lon;    e(2) = lat
    call latlon2xyz(e, p3)

 end subroutine latlon2xyz2


 subroutine latlon2xyz(p, e)
!
! Routine to map (lon, lat) to (x,y,z)
!
 real(ESMF_KIND_R8), intent(in) :: p(2)
 real(ESMF_KIND_R8), intent(out):: e(3)

 integer n
 real(ESMF_KIND_R8) :: q(2)
 real(ESMF_KIND_R8) :: e1, e2, e3

    do n=1,2
       q(n) = p(n)
    enddo

    e1 = cos(q(2)) * cos(q(1))
    e2 = cos(q(2)) * sin(q(1))
    e3 = sin(q(2))
!-----------------------------------
! Truncate to the desired precision:
!-----------------------------------
    e(1) = e1
    e(2) = e2
    e(3) = e3

 end subroutine latlon2xyz

 subroutine vect_cross(e, p1, p2)
 real(ESMF_KIND_R8), intent(in) :: p1(3), p2(3)
 real(ESMF_KIND_R8), intent(out):: e(3)
!
! Perform cross products of 3D vectors: e = P1 X P2
!
      e(1) = p1(2)*p2(3) - p1(3)*p2(2)
      e(2) = p1(3)*p2(1) - p1(1)*p2(3)
      e(3) = p1(1)*p2(2) - p1(2)*p2(1)

 end subroutine vect_cross

 subroutine mirror_latlon(lon1, lat1, lon2, lat2, lon0, lat0, lon3, lat3)
!
! Given the "mirror" as defined by (lon1, lat1), (lon2, lat2), and center 
! of the sphere, compute the mirror image of (lon0, lat0) as  (lon3, lat3)

 real(ESMF_KIND_R8), intent(in):: lon1, lat1, lon2, lat2, lon0, lat0
 real(ESMF_KIND_R8), intent(out):: lon3, lat3
!
 real(ESMF_KIND_R8) p0(3), p1(3), p2(3), nb(3), pp(3), sp(2)
 real(ESMF_KIND_R8) pdot
 integer k

 call latlon2xyz2(lon0, lat0, p0)
 call latlon2xyz2(lon1, lat1, p1)
 call latlon2xyz2(lon2, lat2, p2)
 call vect_cross(nb, p1, p2)

 pdot = sqrt(nb(1)**2+nb(2)**2+nb(3)**2)
 do k=1,3
    nb(k) = nb(k) / pdot
 enddo

 pdot = p0(1)*nb(1) + p0(2)*nb(2) + p0(3)*nb(3)
 do k=1,3
    pp(k) = p0(k) - 2.*pdot*nb(k)
 enddo

 call cart_to_latlon(1, pp, sp(1), sp(2))
 lon3 = sp(1)
 lat3 = sp(2)

 end subroutine  mirror_latlon


 subroutine cart_to_latlon(np, q, xs, ys)
! vector version of cart_to_latlon1
  integer, intent(in):: np
  real(ESMF_KIND_R8), intent(inout):: q(3,np)
  real(ESMF_KIND_R8), intent(inout):: xs(np), ys(np)
! local
  real(ESMF_KIND_R8), parameter:: esl=1.e-10
  real(ESMF_KIND_R8) :: p(3)
  real(ESMF_KIND_R8) :: dist, lat, lon
  integer i,k

  do i=1,np
     do k=1,3
        p(k) = q(k,i)
     enddo
     dist = sqrt(p(1)**2 + p(2)**2 + p(3)**2)
     do k=1,3
        p(k) = p(k) / dist
     enddo

     if ( (abs(p(1))+abs(p(2)))  < esl ) then
          lon = 0.
     else
          lon = atan2( p(2), p(1) )   ! range [-pi,pi]
     endif

     if ( lon < 0.) lon = 2.*pi + lon
     lat = asin(p(3))
     
     xs(i) = lon
     ys(i) = lat
! q Normalized:
     do k=1,3
        q(k,i) = p(k)
     enddo
  enddo

 end  subroutine cart_to_latlon

 subroutine cart_to_latlon_new(q, xs, ys)
    ! vector version of cart_to_latlon1
    real(ESMF_KIND_R8), intent(inout) :: q(:,:,:)
    real(ESMF_KIND_R8), intent(inout) :: xs(:,:), ys(:,:)
    
    ! local
    real(ESMF_KIND_R8), parameter:: esl=1.e-10
    real(ESMF_KIND_R8) :: p(3)
    real(ESMF_KIND_R8) :: dist, lat, lon
    integer i, j, k
    
    
    do j = 1, size(q,3)
       do i = 1, size(q,2)
          p = q(:,i,j)
          
          dist = sqrt(p(1)**2 + p(2)**2 + p(3)**2)
          p = p/dist
          
          if ( (abs(p(1))+abs(p(2)))  < esl ) then
             lon = 0.
          else
             lon = atan2( p(2), p(1) )   ! range [-pi,pi]
          endif
          
          if ( lon < 0.) lon = 2.*pi + lon
          lat = asin(p(3))
          
          xs(i,j) = lon
          ys(i,j) = lat
          ! q Normalized:
          q(:,i,j) = p
       enddo
    end do
    
 end  subroutine cart_to_latlon_new

 subroutine cell_center2(q11, q12, q21, q22, q31, q32, q41, q42, e2)
      real(ESMF_KIND_R8) , intent(in)  :: q11, q12, q21, q22, q31, q32, q41, q42
      real(ESMF_KIND_R8) , intent(out) :: e2(2)
! Local
      real(ESMF_KIND_R8) p1(3), p2(3), p3(3), p4(3)
      real(ESMF_KIND_R8) ec(3)
      real(ESMF_KIND_R8) dd
      integer k
      
      call latlon2xyz2(q11, q12, p1)
      call latlon2xyz2(q21, q22, p2)
      call latlon2xyz2(q31, q32, p3)
      call latlon2xyz2(q41, q42, p4)

      do k=1,3
         ec(k) = p1(k) + p2(k) + p3(k) + p4(k)
      enddo
      dd = sqrt( ec(1)**2 + ec(2)**2 + ec(3)**2 )

      do k=1,3
         ec(k) = ec(k) / dd
      enddo

      call cart_to_latlon(1, ec, e2(1), e2(2))

 end subroutine cell_center2

  subroutine direct_transform(stretch_factor, lon_p, lat_p, lon, lat)
    real(ESMF_KIND_R8),    intent(in):: stretch_factor !< Stretching factor
    real(ESMF_KIND_R8),    intent(in):: lon_p, lat_p   !< center location of the target face, radian
!  0 <= lon <= 2*pi ;    -pi/2 <= lat <= pi/2
    real(ESMF_KIND_R8), intent(inout) :: lon(:,:), lat(:,:)
!
    real(f_p) :: lat_t, sin_p, cos_p, sin_lat, cos_lat, sin_o, p2, two_pi
    real(f_p) :: c2p1, c2m1, one, near_zero, f_p_lon, f_p_lat
    integer:: i, j

    one = 1.d0
    near_zero = tiny(near_zero)
    p2 = 0.5d0*pi
    two_pi = 2.d0*pi

    c2p1 = 1.d0 + stretch_factor*stretch_factor
    c2m1 = 1.d0 - stretch_factor*stretch_factor

    sin_p = sin(lat_p)
    cos_p = cos(lat_p)

    do j=1,size(lon,2)
       do i=1,size(lon,1)
          f_p_lon = lon(i,j)
          f_p_lat = lat(i,j)
          if ( abs(c2m1) > near_zero ) then
               sin_lat = sin(f_p_lat) 
               lat_t = asin( (c2m1+c2p1*sin_lat)/(c2p1+c2m1*sin_lat) )
          else         ! no stretching
               lat_t = f_p_lat
          endif
          sin_lat = sin(lat_t) 
          cos_lat = cos(lat_t) 
            sin_o = -(sin_p*sin_lat + cos_p*cos_lat*cos(f_p_lon))
          if ( (one-abs(sin_o)) < near_zero ) then    ! poles
               f_p_lon = 0.d0
               f_p_lat = sign( p2, sin_o )
          else
               f_p_lat = asin( sin_o )
               f_p_lon = lon_p + atan2( -cos_lat*sin(f_p_lon),   &
                          -sin_lat*cos_p+cos_lat*sin_p*cos(f_p_lon))
               if ( f_p_lon < 0.d0 ) then
                    f_p_lon = f_p_lon + two_pi
               elseif( f_p_lon >= two_pi ) then
                    f_p_lon = f_p_lon - two_pi
               endif
          endif
          lon(i,j) = f_p_lon
          lat(i,j) = f_p_lat
       enddo
    enddo

  end subroutine direct_transform

  !-----------
  ! New version of coordinate calculations
  !
  ! These only require allocation of arrays that span local domain and
  ! are far more accurate due to careful construction of symmetric
  ! loops.
  
  subroutine get_gnomonic_local_coords(grid_type, im, start, lon, lat)
     integer, intent(in) :: grid_type
     integer, intent(in) :: im
     integer, intent(in) :: start(:)
     real(ESMF_KIND_R8), intent(out):: lon(:,:)
     real(ESMF_KIND_R8), intent(out):: lat(:,:)

     integer i, j

     select case (grid_type)
     case (0)
        call get_gnomonic_ed_coords(im, start, lon, lat)
     case (1)
        call get_gnomonic_dist_coords(im, start, lon, lat)
     case (2)
        call get_gnomonic_angl_coords(im, start, lon, lat)
     end select

     if (grid_type < 3) then
        lon = lon - pi
     end if

  end subroutine get_gnomonic_local_coords

  subroutine get_gnomonic_ed_coords(im, start, lambda, theta)
     integer, intent(in) :: im
     integer, intent(in) :: start(:)
     real(ESMF_KIND_R8), intent(out) :: lambda(start(1):, start(2):)
     real(ESMF_KIND_R8), intent(out) :: theta(start(1):, start(2):)


     ! Local:
     real(ESMF_KIND_R8) :: pp(3,lbound(lambda,1):ubound(lambda,1), lbound(lambda,2):ubound(lambda,2))
     real(ESMF_KIND_R8) :: rsq3, alpha, beta, dely
     real(ESMF_KIND_R8) :: b(1:im+1)
     integer i, j

     rsq3 = 1./sqrt(3.) 
     alpha = asin( rsq3 )
     dely = alpha / im

    ! Compute distances along cube edge (segment) at equispaced
     ! angles.  The formula is same for i and for j, but for local
     ! region these may or may not overlap.   Worst case we
     ! do this twice for a "diagonal subdomain"

     do i = lbound(lambda,1), ubound(lambda,1)
        beta = -dely * (im + 2 - 2*i)
        b(i) = tan(beta)*cos(alpha)
     end do

     do j = lbound(lambda,2), ubound(lambda,2)
        beta = -dely * (im + 2 - 2*j)
        b(j) = tan(beta)*cos(alpha)
     end do

     ! Use the edge position to construct an array of
     ! cartesian points in the local domain.
     do j = lbound(lambda,2), ubound(lambda,2)
        do i = lbound(lambda,1), ubound(lambda,1)
           pp(:,i,j) = [-rsq3, -b(i), b(j)]
        end do
     end do

     call cart_to_latlon_new(pp, lambda, theta)

  end subroutine get_gnomonic_ed_coords
  subroutine get_gnomonic_angl_coords(im, start, lambda, theta)
     integer, intent(in) :: im
     integer, intent(in) :: start(:)
     real(ESMF_KIND_R8), intent(out) :: lambda(start(1):, start(2):)
     real(ESMF_KIND_R8), intent(out) :: theta(start(1):, start(2):)

     ! Local
     real(ESMF_KIND_R8) p(3,im+1,im+1)
     real(ESMF_KIND_R8) rsq3
     real(ESMF_KIND_R8) dp
     integer i,j

     dp = (pi/4) /real(im,ESMF_KIND_R8)
     rsq3 = 1./sqrt(3.) 
     do j = lbound(lambda,2), ubound(lambda,2)
        do i = lbound(lambda,1), ubound(lambda,1)
           p(1,i,j) =-rsq3               ! constant
           p(2,i,j) =-rsq3*tan(dp * (im + 2 - 2*i))
           p(2,i,j) =+rsq3*tan(dp * (im + 2 - 2*j))
        enddo
     enddo

     call cart_to_latlon_new(p, lambda, theta)

  end subroutine get_gnomonic_angl_coords


  ! It is important to use symmetric expressions for coordinates here.
  ! This avoids the need for a subsequent forced symmetrization which in turn
  ! thwarts fully local computation of coordinates.
  subroutine get_gnomonic_dist_coords(im, start, lambda, theta)
     integer, intent(in) :: im
     integer, intent(in) :: start(:)
     real(ESMF_KIND_R8), intent(out) :: lambda(start(1):, start(2):)
     real(ESMF_KIND_R8), intent(out) :: theta(start(1):, start(2):)

     ! Local
     real(ESMF_KIND_R8) rsq3, xf
     real(ESMF_KIND_R8) dx
     real(ESMF_KIND_R8) p(3,lbound(lambda,1):ubound(lambda,1),lbound(lambda,2):ubound(lambda,2))
     integer i, j

     ! Face-2

     rsq3 = 1./sqrt(3.) 
     xf = -rsq3
     dx = rsq3/im

     do j = lbound(lambda,2), ubound(lambda,2)
        do i = lbound(lambda,1), ubound(lambda,1)
           p(1,i,j) = xf
           p(2,i,j) = +dx * (im + 2 - 2*i)
           p(3,i,j) = -dx * (im + 2 - 2*j)
        enddo
     enddo
     call cart_to_latlon_new(p, lambda, theta)

  end subroutine get_gnomonic_dist_coords


  subroutine mirror_grid_local_new(local_tile, tileno)
     real(ESMF_KIND_R8)   , intent(INOUT) :: local_tile(:,:,:)
     integer, intent(IN)    :: tileno

     integer :: i,j,n,n1,n2,nreg, npx, npy
     real(ESMF_KIND_R8) :: x1,y1,z1, x2,y2,z2, ang, sa, ca

     if (tileno == 1) then
        ! no op
     else
        do j = 1, size(local_tile,2)
           do i = 1, size(local_tile,1)

              x1 = local_tile(i,j,1)
              y1 = local_tile(i,j,2)
              z1 = radius

              select case (tileno)
              case (2)
                 ang = -90.
                 sa = -1
                 ca = 0
                 call rot_3d_new( 3, x1, y1, z1, sa, ca, x2, y2, z2, 1)  ! rotate about the z-axis

              case (3)
                 ang = -90.
                 sa = -1
                 ca = 0
                 call rot_3d_new( 3, x1, y1, z1, sa, ca, x2, y2, z2, 1)  ! rotate about the z-axis
                 ang = 90.
                 sa = +1
                 ca = 0
                 call rot_3d_new( 1, x2, y2, z2, sa, ca, x1, y1, z1, 1)  ! rotate about the x-axis
                 x2=x1
                 y2=y1
                 z2=z1

              case (4)
                 ang = -180.
                 sa = 0
                 ca = -1
                 call rot_3d_new( 3, x1, y1, z1, sa, ca, x2, y2, z2, 1)  ! rotate about the z-axis
                 ang = 90.
                 sa = 1
                 ca = 0
                 call rot_3d_new( 1, x2, y2, z2, sa, ca, x1, y1, z1, 1)  ! rotate about the x-axis
                 x2=x1
                 y2=y1
                 z2=z1

              case (5)
                 ang = 90.
                 sa = 1
                 ca = 0
                 call rot_3d_new( 3, x1, y1, z1, sa, ca, x2, y2, z2, 1)  ! rotate about the z-axis
                 ang = 90.
                 sa = 1
                 ca = 0
                 call rot_3d_new( 2, x2, y2, z2, sa, ca, x1, y1, z1, 1)  ! rotate about the y-axis
                 x2=x1
                 y2=y1
                 z2=z1

              case (6)
                 ang = 90.
                 sa = 1
                 ca = 0
                 call rot_3d_new( 2, x1, y1, z1, sa, ca, x2, y2, z2, 1)  ! rotate about the y-axis
                 ang = 0.
                 sa = 0
                 ca = 1
                 call rot_3d_new( 3, x2, y2, z2, sa, ca, x1, y1, z1, 1)  ! rotate about the z-axis
                 x2=x1
                 y2=y1
                 z2=z1

              end select

              local_tile(i,j,1) = x2
              local_tile(i,j,2) = y2

           enddo
        enddo
     endif
  end subroutine mirror_grid_local_new


!! Old global mirror grid which needs to be kept until ESMF_UtilCreateCSCoords() goes away
      subroutine mirror_grid(grid_global,ng,npx,npy,ndims,nregions)
         integer, intent(IN)    :: ng,npx,npy,ndims,nregions
         real(ESMF_KIND_R8)   , intent(INOUT) :: grid_global(1-ng:npx  +ng,1-ng:npy  +ng,ndims,1:nregions)
         integer :: i,j,n,n1,n2,nreg
         real(ESMF_KIND_R8) :: x1,y1,z1, x2,y2,z2, ang
!
!    Mirror Across the 0-longitude
!
         nreg = 1
         do j=1,ceiling(npy/2.)
            do i=1,ceiling(npx/2.)

            x1 = 0.25 * (ABS(grid_global(i        ,j        ,1,nreg)) + &
                         ABS(grid_global(npx-(i-1),j        ,1,nreg)) + &
                         ABS(grid_global(i        ,npy-(j-1),1,nreg)) + &
                         ABS(grid_global(npx-(i-1),npy-(j-1),1,nreg)))
            grid_global(i        ,j        ,1,nreg) = SIGN(x1,grid_global(i        ,j        ,1,nreg))
            grid_global(npx-(i-1),j        ,1,nreg) = SIGN(x1,grid_global(npx-(i-1),j        ,1,nreg))
            grid_global(i        ,npy-(j-1),1,nreg) = SIGN(x1,grid_global(i        ,npy-(j-1),1,nreg))
            grid_global(npx-(i-1),npy-(j-1),1,nreg) = SIGN(x1,grid_global(npx-(i-1),npy-(j-1),1,nreg))

            y1 = 0.25 * (ABS(grid_global(i        ,j        ,2,nreg)) + &   
                         ABS(grid_global(npx-(i-1),j        ,2,nreg)) + &
                         ABS(grid_global(i        ,npy-(j-1),2,nreg)) + &
                         ABS(grid_global(npx-(i-1),npy-(j-1),2,nreg)))
            grid_global(i        ,j        ,2,nreg) = SIGN(y1,grid_global(i        ,j        ,2,nreg))
            grid_global(npx-(i-1),j        ,2,nreg) = SIGN(y1,grid_global(npx-(i-1),j        ,2,nreg))
            grid_global(i        ,npy-(j-1),2,nreg) = SIGN(y1,grid_global(i        ,npy-(j-1),2,nreg))
            grid_global(npx-(i-1),npy-(j-1),2,nreg) = SIGN(y1,grid_global(npx-(i-1),npy-(j-1),2,nreg))
             
           ! force dateline/greenwich-meridion consitency
            if (mod(npx,2) /= 0) then
              if ( (i==1+(npx-1)/2.0) ) then
                 grid_global(i,j        ,1,nreg) = 0.0
                 grid_global(i,npy-(j-1),1,nreg) = 0.0
              endif
            endif

            enddo
         enddo

         do nreg=2,nregions
           do j=1,npy
             do i=1,npx

               x1 = grid_global(i,j,1,1)
               y1 = grid_global(i,j,2,1)
               z1 = radius

               if (nreg == 2) then
                  ang = -90.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
               elseif (nreg == 3) then
                  ang = -90.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
                  ang = 90.
                  call rot_3d( 1, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the x-axis
                  x2=x1
                  y2=y1
                  z2=z1

           ! force North Pole and dateline/greenwich-meridion consitency
                  if (mod(npx,2) /= 0) then
                     if ( (i==1+(npx-1)/2.0) .and. (i==j) ) then
                        x2 = 0.0
                        y2 = pi/2.0
                     endif
                     if ( (j==1+(npy-1)/2.0) .and. (i < 1+(npx-1)/2.0) ) then
                        x2 = 0.0
                     endif
                     if ( (j==1+(npy-1)/2.0) .and. (i > 1+(npx-1)/2.0) ) then
                        x2 = pi
                     endif
                  endif

               elseif (nreg == 4) then
                  ang = -180.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
                  ang = 90.
                  call rot_3d( 1, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the x-axis
                  x2=x1
                  y2=y1
                  z2=z1

               ! force dateline/greenwich-meridion consitency
                  if (mod(npx,2) /= 0) then
                    if ( (j==1+(npy-1)/2.0) ) then
                       x2 = pi
                    endif
                  endif

               elseif (nreg == 5) then
                  ang = 90.
                  call rot_3d( 3, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the z-axis
                  ang = 90.
                  call rot_3d( 2, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the y-axis
                  x2=x1
                  y2=y1
                  z2=z1
               elseif (nreg == 6) then
                  ang = 90.
                  call rot_3d( 2, x1, y1, z1, ang, x2, y2, z2, 1, 1)  ! rotate about the y-axis
                  ang = 0.
                  call rot_3d( 3, x2, y2, z2, ang, x1, y1, z1, 1, 1)  ! rotate about the z-axis
                  x2=x1
                  y2=y1
                  z2=z1

           ! force South Pole and dateline/greenwich-meridion consitency
                  if (mod(npx,2) /= 0) then
                     if ( (i==1+(npx-1)/2.0) .and. (i==j) ) then
                        x2 = 0.0
                        y2 = -pi/2.0
                     endif
                     if ( (i==1+(npx-1)/2.0) .and. (j > 1+(npy-1)/2.0) ) then
                        x2 = 0.0
                     endif
                     if ( (i==1+(npx-1)/2.0) .and. (j < 1+(npy-1)/2.0) ) then
                        x2 = pi
                     endif
                  endif

               endif

               grid_global(i,j,1,nreg) = x2
               grid_global(i,j,2,nreg) = y2

              enddo
            enddo
          enddo

  end subroutine mirror_grid

  !-------------------------------------------------------------------------------
  ! vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv !
  !
  !     rot_3d_new :: rotate points on a sphere in xyz coords given sin
  !                   and cos of angle.  Only works for {0,-1,+1} - 90
  !                   degree rotations.  This approach guarantees
  !                   symmetry by avoiding roundoff associated with
  !                   inexact values of pi (and thus cos(pi/2)).

  !
  subroutine rot_3d_new(axis, x1in, y1in, z1in, sa, ca, x2out, y2out, z2out, convert)

     integer, intent(IN) :: axis         ! axis of rotation 1=x, 2=y, 3=z
     real(ESMF_KIND_R8) , intent(IN)    :: x1in, y1in, z1in
     real(ESMF_KIND_R8) , intent(IN)    :: sa, ca   ! sin and cos of angle to rotate in radians
     real(ESMF_KIND_R8) , intent(OUT)   :: x2out, y2out, z2out
     integer, intent(IN), optional :: convert ! if present convert input point
     ! from spherical to cartesian, rotate, 
     ! and convert back

     real(ESMF_KIND_R8)  :: x1,y1,z1, x2,y2,z2

     if ( present(convert) ) then
        call spherical_to_cartesian(x1in, y1in, z1in, x1, y1, z1)
     else
        x1=x1in
        y1=y1in
        z1=z1in
     endif


     SELECT CASE(axis)

     CASE(1)
        x2 =  x1
        y2 =  ca*y1 + sa*z1
        z2 = -sa*y1 + ca*z1
     CASE(2)
        x2 = ca*x1 - sa*z1
        y2 = y1
        z2 = sa*x1 + ca*z1
     CASE(3)
        x2 =  ca*x1 + sa*y1
        y2 = -sa*x1 + ca*y1
        z2 = z1
     CASE DEFAULT
        write(*,*) "Invalid axis: must be 1 for X, 2 for Y, 3 for Z."

     END SELECT

     if ( present(convert) ) then
        call cartesian_to_spherical(x2, y2, z2, x2out, y2out, z2out)
     else
        x2out=x2
        y2out=y2
        z2out=z2
     endif

  end subroutine rot_3d_new


end module ESMF_UtilCubedSphereMod

