command! -nargs=1 SentencerAbove try
      \ | exec sentencer#pattern(<f-args>, 0)
      \ | catch | echom '[Sentencer]: No sentences found.' | endtry

command! -nargs=1 SentencerBelow try
      \ | exec sentencer#pattern(0, <f-args>)
      \ | catch | echom '[Sentencer]: No sentences found.' | endtry

command! -nargs=1 SentencerExact try
      \ | exec sentencer#pattern(<f-args>, <f-args>)
      \ | catch | echom '[Sentencer]: No sentences found.' | endtry

command! -nargs=+ SentencerBetween try
      \ | exec sentencer#pattern(<f-args>)
      \ | catch | echom '[Sentencer]: No sentences found.' | endtry

command! -nargs=0 SentencerIncrement try 
      \ | exec sentencer#increment()
      \ | exec sentencer#pattern(s:lo, s:hi)
      \ | catch | echom '[Sentencer]: No sentences found.' | endtry

command! -nargs=0 SentencerDecrement try
      \ | exec sentencer#decrement()
      \ | exec sentencer#pattern(s:lo, s:hi)
      \ | catch | echom '[Sentencer]: No sentences found.' | endtry


nnoremap <Leader>K :SentencerIncrement<CR>
nnoremap <Leader>J :SentencerDecrement<CR>
