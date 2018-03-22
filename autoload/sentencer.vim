let s:null = -1
let s:lo = 0
let s:hi = 0

let s:End   = '[\.!?]'
let s:Beg   = '(^|([\.!?] *)@<=)'
let s:Word  = '[^ \n.!?]+'
let s:Space = '[ \n]'

fun! sentencer#increment()
  if s:lo == s:hi " ---------------- Exact
    let s:lo += 1
    let s:hi += 1
  elseif s:lo == 0 " --------------- Below
    let s:hi += 1
  elseif s:hi == 0 " --------------- Above
    let s:lo += 1
  else " --------------------------- Between
    let s:lo += 1
    let s:hi += 1
  endif
endfun

fun! sentencer#decrement()
  if s:lo == s:hi " ---------------- Exact
    if s:lo > 1
      let s:lo -= 1
      let s:hi -= 1
    endif
  elseif s:lo == 0 " --------------- Below
    let s:hi -= (s:hi > 1)? 1 : 0
  elseif s:hi == 0 " --------------- Above
    let s:lo -= (s:lo > 1)? 1 : 0
  else " --------------------------- Between
    let s:lo -= (s:lo > 1)? 1 : 0
    let s:hi -= (s:hi > 1)? 1 : 0
  endif
endfun

fun! s:quantifier(lo, hi)
  if a:lo == a:hi " ---------------- Exact
    return a:lo-1
  elseif a:lo == 0 " --------------- Below
    return ','.(a:hi-1)
  elseif a:hi == 0 " --------------- Above
    return (a:lo-1).','
  else " --------------------------- Between
    return (a:lo-1).','.(a:hi-1)
  endif
endfun

fun! sentencer#pattern(lo, hi)
  " Store arguments globally for SentencerIncrement / SentencerDecrement
  let s:lo = a:lo
  let s:hi = a:hi
  let l:q = s:quantifier(a:lo, a:hi)
  " Sentence Regex
  return '/\v'.
        \ s:Beg.
        \ '('.
        \   s:Word.
        \   s:Space.
        \ '){'.l:q.'}'.
        \ s:Word.
        \ s:End
endfun
