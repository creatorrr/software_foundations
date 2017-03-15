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

2017-02-17 16:51 Installed proof-general.
Had fun with installing a bunch of emacs packages and installed and tried proof-general for the first time. Still trying to get a good hang of things but seems to work like a breeze so far.

2017-02-23 16:42 Back to work.
After a brief relapse into days of self-pity, I am back to work. Still having some trouble with my emacs setup but I am getting the hang of it. Made some new modifications to fix company-coq mucking up and things are working. For now.

2017-02-23 17:16 Starting Coq in a Hurry.
Doing the short tutorial along with exercise solutions.

2017-02-23 18:49 Section 2 done.
Finished sec 2 of Coq in a hurry.

2017-02-25 16:19 A note on turing incompleteness of Coq.

It is very interesting that theorem provers have to be turing-incomplete by design.
It seems to make obvious sense on the surface why this should be the case given the
halting problem but I do wonder whether this is  a fundamental in nature and if it is
is there a proof of it? Could this have any thing to do with Godel's theorems?

Note to self: Discuss with prof.

2017-02-26 16:41 Not enough explanation about tactics.
Enjoying the pace of _Coq in a Hurry_ tutorial but it feels like there is very little explanation about the different tactics in it. Assumes a thorough understanding of proof tactics. Hoping a combination of [Software Foundations](https://www.cis.upenn.edu/~bcpierce/sf/current/Preface.html#lab9) and [Coq cheat sheet](http://andrej.com/coq/cheatsheet.pdf) would enrich my understanding to a more satisfactory level.

2017-02-27 11:32 Learning about Curry-Howard correspondence.
In further research about the turing-incompleteness of Coq and other theorem proving assistants, read about Curry-Howard correspondence which is the direct relationship between computer programs and mathematical proofs. Very interesting! This also formed the basis of Coquand's Calculus of Constructions which is what the Coq system is based on.

2017-02-27 11:36 Moving on to Software Foundations.
Have had enough of the Coq tutorials. While they helped me get my feet wet, I have realized that they are terrible at introducing the different proof strategies out there. Thanks tho.

2017-02-27 14:26 Starting Software Foundations.
The course is interactive in nature with a bunch of Coq files that can be completed for exercises.

2017-02-28 10:04 Software foundations Basics fin.
Just finished the Basics.v set of exercises and tutorials. Extremely enlightening and structured. Goes over all tactics without assuming prereq knowledge while offering enough challenge.

2017-02-28 10:04 I dreamed in Coq last night.
:O :| D: !!!

2017-03-01 09:35 Loving emacs.
Been playing around wit emacs and elisp. Absolutely love it!

2017-03-01 15:05 Finished advanced 5* ex at the end of Basics.
It wasn't nearly as difficult as I expected it to be.

2017-03-01 15:10 "Informal proofs are algorithms; formal proofs are code".
Woah. Mind = blown...

2017-03-02 00:07 Some of the proofs can be surprisingly difficult.
Like the distributive property of mult has been bugging me for hours...

2017-03-02 11:10 Phew!
Finally solved the mult_plus_distr_r proof. Took me triple induction, three previous proofs, two sub-proofs and half a bottle of tylenol.
Note to self: Ask prof if there is a better solution to this and also if there is a tactic to do multiple repeated steps automatically.

2017-03-15 09:44 Finished Induction exercises.
Getting much more comfortable with Coq theorem proving now. The last bits of Induction were challenging but I didn't have to struggle too much. (Note: this post is a week later than it should be owing to some misfortune)

2017-03-15 10:19 The Story of last week.
Due to some very gross miscommunications, I got myself landed in a psych ward for all of last week. As one can expect, it caused a lot of disruption in my work. While they did have computers, (to my horror) they only ran windows with limited privileges and extremely limited internet access (no github) but I was able to get some work done despite through [ProofWeb](http://proofweb.cs.ru.nl/) and Wordpad... ...

Anyway that's the work I just committed, should be able to finish Lists.v by end of today. `rev_injective` was a lot of fun to crack and I spent hours stuck on it.
