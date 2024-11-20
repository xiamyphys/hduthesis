%% ***********************************************************************
%%            Copyright 2024 by M.Y. XIA <xiamyphys@gmail.com>           *
%%                                                                       *
%%    This work may be distributed and/or modified under the conditions  *
%%    of the LaTeX Project Public License                                *
%%                                                                       *
%%               http://www.latex-project.org/lppl.txt                   *
%%                                                                       *
%%    either version 1.3c of this license or any later version.          *
%%                                                                       *
%%    This work has the LPPL maintenance status `maintained'.            *
%%                                                                       *
%%    The Current Maintainers of this work is M.Y. XIA                   *
%%                                                                       *
%%    This work consists of the files hduthesisdoc.cls,                  *
%%    available at https://github.com/xiamyphys/hduthesis                *
%% ***********************************************************************
\def\hduthesisdoc@date{2024/11/20}
\def\hduthesisdoc@version{0.3.2}

\ProvidesExplClass{hduthesisdoc} {\hduthesisdoc@date} {\hduthesisdoc@version}
  {LaTeX Manual Class for LaTeX Package hduthesis}

\LoadClass [ 11pt ] { l3doc }

\keys_define:nn { hduthesisdoc / docinfo }
  {
    title .tl_set:N         = \l__docinfo_title_clist,
    author .tl_set:N        = \l__docinfo_author_tl,
    version .tl_set:N       = \l__docinfo_version_tl,
    CJKmain-font .tl_set:N  = \g__hduthesisdoc_main_CJK_font,
    CJKsans-font .tl_set:N  = \g__hduthesisdoc_sans_CJK_font,
    CJKmono-font .tl_set:N  = \g__hduthesisdoc_mono_CJK_font
  }

\NewDocumentCommand \DocInfo { m }
  {
    \keys_set:nn { hduthesisdoc / docinfo } {#1}
    \title { \bfseries \l__docinfo_title_clist }
    \author { \l__docinfo_author_tl }
    \date
      {
        \l__docinfo_version_tl
        \footnote{\url{https://github.com/xiamyphys/hduthesis}}~ (\today)
      }
    \tl_if_empty:NF \g__hduthesisdoc_main_CJK_font
      { \exp_last_unbraced:No \setCJKmainfont \g__hduthesisdoc_main_CJK_font }
    \tl_if_empty:NF \g__hduthesisdoc_sans_CJK_font
      { \exp_last_unbraced:No \setCJKsansfont \g__hduthesisdoc_sans_CJK_font }
    \tl_if_empty:NF \g__hduthesisdoc_mono_CJK_font
      { \exp_last_unbraced:No \setCJKmonofont \g__hduthesisdoc_mono_CJK_font }
  }

\hypersetup{urlcolor = teal, filecolor = violet}
\hologoFontSetup{general = \sffamily}
\RequirePackage[mono = false]{libertine}
\RequirePackage{geometry,framed,xeCJKfntef,tikz,pdfpages,subcaption,fadingimage}
\setlength{\oddsidemargin}{63pt}\setlength{\evensidemargin}{63pt}
\FrameSep = 0pt 
\RequirePackage[os = mac]{menukeys}
\AddToHook{env/function/before}{\vspace{-.3\baselineskip}}
\AddToHook{env/syntax/after}{\vspace{-.2\baselineskip}}
\RequirePackage{datetime}\yyyymmdddate
\RequirePackage[fontset = none, scheme = plain]{ctex}\linespread{1.5}
\renewcommand{\emph}[1]{\CJKsout*[thickness=2.5ex, format=\color{blue!15}]{#1}}

\def\HoLogo@hduthesis#1{%
  \raisebox{-.5pt}
    {
      \HOLOGO@mbox
        {
          \tikz[baseline = (hduthesis.base)]
          {
              \node [ inner~sep = 0pt ] (hduthesis)
                {\textsc{\cls{hduThesi\scalebox{1.2}[1.2]{S}}}};
              \draw
               let \p1 = (hduthesis.west), \p2 = (hduthesis.east)
               in (\x1,\y1) (\x2,\y2)
              [line~width = {.028pt*(\x2 - \x1)}]
              ([yshift = -.5ex]hduthesis.north~west) to[bend~right = 5]
              ([yshift = .25ex]hduthesis.north~east);
          }
        }
    }
 }

\let \legacy@maketitle \maketitle
\RenewDocumentCommand \maketitle {}
  {
    \titlepage
    \newgeometry{margin = 1in}
    \legacy@maketitle
    \begin{center}
      \tikz
        {
          \node [ opacity = .8 ] 
            { \includegraphics[width = .15\paperwidth]{hdumotto.pdf} };
          \node [ opacity = .3 ]
            { \includegraphics[width = .21\paperwidth]{hdulogo.pdf} };
      }
    \end{center}
  }

\NewDocumentCommand \mailto {m}
  { \texttt{<\href{mailto:#1}{#1}>} }
\pdfstringdefDisableCommands
  { \def\mailto#1{<#1>} }

\endinput

% End of file hduthesisdoc.cls
