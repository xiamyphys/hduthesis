%% ***********************************************************
%%   Copyright 2024 by M.Y. XIA <xiamyphys@gmail.com>        *
%%                                                           *
%%   This work may be distributed and/or modified under      *
%%   the conditions of the LaTeX Project Public License      *
%%                                                           *
%%       http://www.latex-project.org/lppl.txt               *
%%                                                           *
%%   either version 1.3c of this license or any later        *
%%   version.                                                *
%%                                                           *
%%   This work has the LPPL maintenance status `maintained'. *
%%                                                           *
%%   The Current Maintainers of this work is M.Y. XIA        *
%%                                                           *
%%   This work consists of the files hduthesis.cls,          *
%%                               and README.md.              *
%%   available at https://github.com/xiamyphys/hduthesis     *
%% ***********************************************************
\RequirePackage{xparse}% For TeX Live 2019 - 2020 Compatibility
\PassOptionsToPackage{quiet}{xeCJK}
\ProvidesExplClass{hduthesis}{2024/10/01}{3.1B}{HDU Thesis Class}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[11pt, a4paper]{report}

\RequirePackage[scheme = plain]{ctex}
\RequirePackage{geometry, tikz, array}
\geometry
{
  top = 3cm, bottom = 2cm, left = 3.5cm, right = 2cm
}
\graphicspath
{
  {./figure/}{./figures/}{./image/}{./images/}
  {./graphics/}{./graphic/}{./pictures/}{./picture/}
}
\setmainfont{texgyretermes}
[
  UprightFont = *-regular,
  BoldFont = *-bold,
  ItalicFont = *-italic,
  BoldItalicFont = *-bolditalic,
  Extension = .otf,
  Scale = 1.0
]
\setsansfont{texgyreheros}
[
  UprightFont = *-regular,
  BoldFont = *-bold,
  ItalicFont = *-italic,
  BoldItalicFont = *-bolditalic,
  Extension = .otf,
  Scale = 0.9
]

\keys_define:nn { hduthesis / coverinfo }
{
  grade.tl_set:N = \l__cover_grade_tl,
  title.tl_set:N = \l__cover_title_tl,
  school.tl_set:N = \l__cover_school_tl,
  major.tl_set:N = \l__cover_major_tl,
  class.tl_set:N = \l__cover_class_tl,
  stdntid.tl_set:N = \l__cover_stdntid_tl,
  author.tl_set:N = \l__cover_author_tl,
  supervisor.tl_set:N = \l__cover_supervisor_tl,
}
\NewDocumentCommand \CoverInfo { m }
{ \keys_set:nn { hduthesis / coverinfo } { #1 } }

\cs_new_protected:Npn \l_spread_box:nn #1#2
{
  \mode_leave_vertical:
  \hbox_to_wd:nn {#1}
  { \tl_map_inline:Nn {#2} { ##1 \hfil } \unskip }
}
\cs_new_protected:Npn \l_center_box:nn #1#2
{
  \mode_leave_vertical:
  \dim_set:Nn \l_tmpa_dim {#1}
  \dim_add:Nn \l_tmpa_dim {0.6em}
  \makebox[0cm][l]{\rule[-.8ex]{\l_tmpa_dim}{.5 pt}}
  {\hbox_to_wd:nn {\l_tmpa_dim} { \hfil #2 \hfil }}
}

\cs_new_protected_nopar:Nn \__litetable_course_box_aux:
{
  \begin{center}
    \vspace*{2.6\baselineskip}
    \includegraphics{hdubrand}
    \par\vspace*{3\baselineskip}
    \scalebox{4}
    {
      \l_spread_box:nn {.2\linewidth} {本科毕业设计}
    }
    \par\vspace*{1.5\baselineskip}
    {
      \huge（\l__cover_grade_tl 届）
    }
    \par\vspace*{6.2\baselineskip}
    \begin{tabular}
      {
        >{\Large}p{6\ccwd}@{}
        >{\Large\centering\arraybackslash\kaishu}p{.6\linewidth}
      }
      题\qquad 目 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_title_tl}\\[3.33em]
      学\qquad 院 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_school_tl}\\[3.33em]
      专\qquad 业 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_major_tl}\\[3.33em]
      班\qquad 级 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_class_tl}\\[3.33em]
      学\qquad 号 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_stdntid_tl}\\[3.33em]
      学生姓名 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_author_tl}\\[3.33em]
      指导教师 & 
      \l_center_box:nn{.93\linewidth}{\l__cover_supervisor_tl}\\[3.33em]
      完成日期 &
      \l_center_box:nn{.93\linewidth}{
        \textsf{\int_use:N \c_sys_year_int} 年
        \textsf{\int_use:N \c_sys_month_int} 月
      }
    \end{tabular}
  \end{center}
}

\RequirePackage{fancyhdr}
\chead{杭州电子科技大学本科毕业设计（论文）}
\pagestyle{fancy}

\RenewDocumentCommand \maketitle {}
{
  \__litetable_course_box_aux:
  \thispagestyle{empty}
  \clearpage
  \vspace*{4.8\baselineskip}
  \begin{center}
    \LARGE\textsf{\bfseries \l_spread_box:nn {6\ccwd}{诚信承诺}}
  \end{center}
  \vspace*{.5\baselineskip}\par
  \linespread{2}\Large
  我谨在此承诺：本人所写的毕业论文《\l__cover_title_tl》均系本人独立完成，
  没有抄袭行为，凡涉及其他作者的观点和材料，均作了注释，
  若有不实，后果由本人承担。
  \par
  \vspace*{\baselineskip}
  \l_spread_box:nn {.48\linewidth}{}\textsf{\bfseries 承诺人（签名）：}
  \par
  \l_spread_box:nn {.48\linewidth+2em}{}\textsf{\bfseries 年\qquad 月\qquad 日}
  \thispagestyle{empty}
}