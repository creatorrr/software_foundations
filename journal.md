2017-02-15 19:30 Init.
Starting CS project under Prof Stephen Edwards @Columbia. This is going to be a log of thoughts and notes I make during the project.

2017-02-15 19:34 Installing Coq.
Seems rather simple to just use apt's version but to keep things consistent, I'm going to build version 8.6 (latest as of now) from sources.

2017-02-15 19:49 Stages of project.
Stage 1: Learn Coq, since I'm a complete beginner
Stage 2: Read, understand and dissect the paper in question
Stage 3: Implement a formal of proof of the required section

2017-02-15 19:52 Learning Coq.
Using the following references (in order of precedence):

 - Software Foundations, Benjamin Pierce, https://www.cis.upenn.edu/~bcpierce/sf/current/index.html
 - Coq Official tutorial, Huet, Kahn and Paulin, https://coq.inria.fr/distrib/V8.6/files/Tutorial.pdf
 - Coq in a hurry, Yves Bertot, https://cel.archives-ouvertes.fr/inria-00001173v5/document

2017-02-15 19:57 Installing Coq successful.

> coqc -v
>  The Coq Proof Assistant, version 8.6 (February 2017)
>  compiled on Feb 15 2017 19:45:37 with OCaml 4.02.3

2017-02-15 19:59 Changing journal format to markdown.

2017-02-16 10:43 Hate CoqIDE.
Trying to install a vim plugin that emulates coqIDE called [coquille](https://github.com/the-lambda-church/coquille) but running into problems with my vim install (it only has Python3 support but the plugin needs python2 support). Jesus Christ! Pythoners, get your #$%# together already.

2017-02-16 10:47 

2017-02-16 11:13 Coq works with vim now.
Yay! I had to re-add te vim 8.x ppa and reinstall with python2-only support. I'd much rather prefer to re-compile vim with dynamic python2/3 support but I'm too lazy... Anyway, good news is the setup works now so adios coqIDE.

2017-02-16 11:17 Coquille vimrc settings.

> let g:coquille_auto_move="true"
> au FileType coq call coquille#CoqideMapping()

2017-02-16 11:39 #$#%@ing vim.
Now my vim doesn't have clipboard support. Great. Gotta recompile from sources I guess. -_-"

2017-02-16 11:47 %##$ing Coquille.
So apparently, coquille only works for Coq ver <= 8.4 FML. Looking at other options and reinstating my previous vim setup.

2017-02-16 16:28 Learnign emacs.
After much tinkering with coq options for vim or neovim, it doesn't seem like a feasible environment to work in. I still hate coqIDE enough to not use it despite that so we are left with two options:

 - Patch coquille to work with later Coq versions which for reasons mentioned [here](https://github.com/the-lambda-church/coquille/issues/31) are non-trivial. Also, since coquille wasn't written with the new async process model of vim8.x, it's probably going to be a complete rewrite.

 - Suck it up and learn emacs. I have decided to go with this option because:
   1. I have always wanted to learn emacs but never had sufficient motivation.
   2. This is going to be helpful in going o using Agda and the like.
   3. I'm a natural lisper.

2017-02-16 17:08 My emacs setup.
Currently starting with **evil-mode**, obviously. A mix of my own tweaks, [this](https://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html) and [this](https://juanjoalvarez.net/es/detail/2014/sep/19/vim-emacsevil-chaotic-migration-guide/).

2017-02-16 17:09 Emacs baby steps.
Still struggling but I am actually beginning to like it. Maybe it was for the better...
