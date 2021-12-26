program part1
  implicit none

  character(:), allocatable :: input_file_name
  character, allocatable :: grid(:, :), new_grid(:, :)
  integer input_file_name_length
  character(1) :: input_line_buffer
  integer m, n, x, y, step, io
  logical moved

  call get_command_argument(number=1, length=input_file_name_length)
  allocate (character(input_file_name_length) :: input_file_name)
  call get_command_argument(number=1, value=input_file_name)

  open (1, file = input_file_name, status = 'old')

  m = 0
  do
    read(1, *, iostat=io)
    if (io /= 0) exit
    m = m + 1
  end do
  rewind(1)

  n = 0
  do
    read(1, '(A1)', iostat=io, advance='no') input_line_buffer
    if (io /= 0) exit
    n = n + 1
  end do
  rewind(1)

  allocate(grid(m, n))
  do y = 1,m
    read(1, '(*(A1))') grid(y, :)
  end do

  step = 0
  moved = .true.
  do while (moved)
    step = step + 1
    moved = .false.

    new_grid = grid
    do y = 1, m
      do x = 1, n
        if (grid(y, x) == '>' .and. grid(y, mod(x, n) + 1) == '.') then
          new_grid(y, mod(x, n) + 1) = '>'
          new_grid(y, x) = '.'
          moved = .true.
        end if
      end do
    end do

    grid = new_grid
    do y = 1, m
      do x = 1, n
        if (grid(y, x) == 'v' .and. grid(mod(y, m) + 1, x) == '.') then
          new_grid(mod(y, m) + 1, x) = 'v'
          new_grid(y, x) = '.'
          moved = .true.
        end if
      end do
    end do

    grid = new_grid
  end do

  print '(I0)', step
end program part1
