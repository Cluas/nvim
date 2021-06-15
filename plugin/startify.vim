let s:header = [
              \ '+-------------------------------------------+',
              \ '|                   ^_^                     |',
              \ '|               Clean Code.                 |',
              \ '|                                           |',
              \ '|     GitHub: https://github.com/Cluas      |',
              \ '+-------------------------------------------+',
              \ ]

function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)