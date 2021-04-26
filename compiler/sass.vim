" Compiler: Sass
" Maintainer: Little Clover <littleclover909@gmail.com>
" Last Change: 2021 Apr 26

if exists("current_compiler")
  finish
endif

let s:css_dir = expand("%:p:h:h") . "/css/"
let s:css_file = s:css_dir . "main.css"

fun s:call_shell(cmd, arg)
  if has('nvim')
    call jobstart(split(&shell) + split(&shellcmdflag) + [ a:cmd . ' ' . a:arg ])
  elseif has('vim') && v:version >= 800
    call job_start(split(&shell) + split(&shellcmdflag) + [ a:cmd . ' ' . a:arg ])
  else
    echoerr "Current Vim version doesn't support async jobs, consider update to Vim 0.8.0 or later"
  endif
endfun

fun s:create_css()
  if isdirectory(s:css_dir)
    if !empty(glob(s:css_file))
      return
    endif
    call s:call_shell('touch', s:css_file)
  else
    call s:call_shell('mkdir', s:css_dir)
    call s:call_shell('touch', s:css_file)
  endif
  return
endfun

call s:create_css()

let current_compiler = "sass"
CompilerSet makeprg=sass\ %\ >\ %:p:h:h/css/main.css
CompilerSet errorformat=
