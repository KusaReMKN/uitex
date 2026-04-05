\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uitex}[2026/02/22 v0.1 UITEX by KusaReMKN]

% This file contains portions derived from abenori/jlreq.
% jlreq and jlreq-trimmarks
% Copyright 2017-2024, Noriyuki Abe.  All rights reserved.

\PassOptionsToClass{
  oneside,
  twocolumn,
  fleqn,
  paper=a4paper,
  fontsize=9bp,
  baselineskip={165zh/100},
  head_space=81bp,
  foot_space=54bp,
  gutter=20mm,
  fore-edge=20mm,
  column_gap=10mm,
  open_bracket_pos=nibu_tentsuki,
}{jlreq}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{jlreq}
}
\ProcessOptions\relax
\LoadClass{jlreq}

\setlength{\headsep}{1\jlreq@zh}
\setlength{\footskip}{\baselineskip}

\jlreqsetup{caption_font=\rmfamily\normalsize}
\jlreqsetup{caption_label_font=\rmfamily\normalsize}

\jlreqsetup{itemization_beforeafter_space=0bp}

\ModifyHeading{section}{
  font=\gtfamily\fontsize{12bp}{\baselineskip}\selectfont,
  label_format={\thesection.},
  after_label_space=1\jlreq@zw,
  lines=1,
  before_lines=1,
  after_lines=1,
}
\ModifyHeading{subsection}{
  font=\gtfamily\normalsize,
  label_format={\thesubsection.},
  after_label_space=1.7\jlreq@zw,
  lines=1,
  before_lines=1,
}
\ModifyHeading{subsubsection}{
  font=\gtfamily\normalsize,
  label_format={\thesubsubsection.},
  after_label_space=1.7\jlreq@zw,
  lines=1,
  before_lines=1,
}
\SetBlockHeadingSpaces{
  { _section{*}, _subsection{lines=1} }
  { _section{*}, _subsection{lines=1}, _subsubsection{lines=1} }
  { _subsection{*}, _subsubsection{lines=1} }
}

\NewDocumentCommand\@ForumYear{}{20xx}
\NewDocumentCommand\ForumYear{m}{\RenewDocumentCommand\@ForumYear{}{#1}}
\NewDocumentCommand\@ForumNumber{}{nn}
\NewDocumentCommand\ForumNumber{m}{\RenewDocumentCommand\@ForumNumber{}{#1}}
\NewDocumentCommand\@ForumDate{}{YYYY/mm/dd〜dd}
\NewDocumentCommand\ForumDate{m}{\RenewDocumentCommand\@ForumDate{}{#1}}

\NewPageStyle{forum}{
  yoko,
  running_head_font=\sffamily,
  nombre_font=\sffamily,
  nombre_position=bottom-left,
  nombre={（{\@ForumDate}）},
  odd_running_head={
    PTUフォーラム{\@ForumYear}，
    第{\@ForumNumber}回 職業能力開発研究発表講演会 講演論文
  },
  %odd_head_format={\underline{\makebox[\jlreqyokoheadlength]{#1}}},
  odd_head_format={\framebox(\jlreqyokoheadlength,0pt){\raisebox{15bp}{#1}}},
  %odd_foot_format={$\overline{\text{\makebox[\jlreqyokoheadlength]{\rule{0bp}{.6\baselineskip}#1}}}$},
  odd_foot_format={\raisebox{9bp}[0bp][0bp]{\framebox(\jlreqyokoheadlength,0pt)[l]{\raisebox{-27bp}{#1}}}},
}

% 表題とか著者とか表示する
% https://github.com/abenori/jlreq/blob/2ec6a41e45a779f547436075d8abcbf5b26ff334/jlreq.cls#L5580-L5606
\RenewDocumentCommand\@maketitle{}{
  \newpage\null
  {
    \centering
    % XXX: 雰囲気
    %\vskip.1\baselineskip
    {
      \sffamily
      \bfseries
      % XXX: 行送りは雰囲気
      \fontsize{14bp}{1.25\baselineskip}\selectfont
      \@title
      \par
    }
    \vskip\baselineskip
    {
      \sffamily
      % XXX: 行送りは雰囲気
      \fontsize{12bp}{1.1\baselineskip}\selectfont
      \begin{tabular}[t]{c}
        \@author
      \end{tabular}
      \par
    }
    \vskip2\baselineskip
  }
}

% \maketitle でページスタイルをリセットしないように改変
% https://github.com/abenori/jlreq/blob/2ec6a41e45a779f547436075d8abcbf5b26ff334/jlreq.cls#L5531-L5561
\RenewDocumentCommand\maketitle{}{
  \par
  \begingroup
    \RenewDocumentCommand\thefootnote{}{\fnsymbol{footnote}}
    \RenewDocumentCommand\@makefnmark{}{\hbox{
      \jlreq@iftdir{\yoko}{}
      \rlap{\@textsuperscript{\normalfont\@thefnmark}}
    }}
    \RenewDocumentCommand\jlreq@referencemark@format{m}{\@makefnmark}
    \if@twocolumn
      \ifnum\col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]
      \fi
    \else
      \newpage
      \global\@topnum\z@
      \@maketitle
    \fi
    \@thanks
  \endgroup
  \jlreq@endofmaketitle
}

% 参考文献をちょろっと
% https://github.com/abenori/jlreq/blob/2ec6a41e45a779f547436075d8abcbf5b26ff334/jlreq.cls#L6012-L6035
\RenewDocumentEnvironment{thebibliography}{m}{
  \jlreq@oldfontcommand@enable
  \vskip\baselineskip
  \noindent\framebox(\linewidth,0pt){\raisebox{15bp}{\sffamily\refname}}\par
  \@mkboth{\refname}{\refname}
  % XXX: 行送りは雰囲気
  \fontsize{8bp}{.8\baselineskip}\selectfont
  \list{\@biblabel{\@arabic\c@enumiv}}{
    \settowidth\labelwidth{\@biblabel{#1}}
    \labelsep=1\jlreq@zw
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemindent=0bp
    \@openbib@code
    \usecounter{enumiv}
    \let\p@enumiv\@empty
    \RenewDocumentCommand\theenumiv{}{\@arabic\c@enumiv}
  }
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000
  \sfcode`\.\@m
}{
  \def\@noitemerr{\@latex@warning{Empty~`thebibliography'~environment}}%
  \endlist
  \jlreq@oldfontcommand@disable
}

% 上付き用文献引用
\NewDocumentCommand\Cite{m}{\kern0pt\textsuperscript{\cite{#1}}}

% 表を少しだけ小さく表示する
\RenewDocumentEnvironment{table}{o}{
  \@float{table}[#1]
  \small
}{
  \end@float
}

% 表の上下に使う太めの罫線
\def\Hline{\noalign{\hrule height 1bp}}

% 行列関連が高すぎるので調整
\setlength\jot{-3bp}

% ex: se et ts=2 :
