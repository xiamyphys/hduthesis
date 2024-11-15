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
%%    This work consists of the files hduthesis.cls,                     *
%%                                    hduthesis-font-module.code,        *
%%                                    hduthesis-preamble-module.code,    *
%%                                    hduthesis-unv.layout-module.code,  *
%%                                    hduthesis-bc.layout-module.code,   *
%%                                    hduthesis-pg.layout-module.code,   *
%%                                and README.md.                         *
%%    available at https://github.com/xiamyphys/hduthesis                *
%% ***********************************************************************
\def\hduthesis@date{2024/10/10}
\def\hduthesis@version{0.2.1}

\RequirePackage{etoolbox}
\ProvidesExplClass{hduthesis} {\hduthesis@date} {\hduthesis@version}
{HDU Thesis Class}

\cs_new_protected:Npn \hduthesis_msg_new:nn #1#2 
  { \msg_new:nnn { hduthesis } {#1} {#2} }
\cs_new_protected:Npn \hduthesis_msg_error:nn #1#2
  { \msg_error:nnn { hduthesis } {#1} {#2} }

\hduthesis_msg_new:nn { 用户协议 }
  { \exp_not:n
    {
      ⚠️⚠️⚠️⚠️⚠️⚠️~「HduThesis」编译受阻~⚠️⚠️⚠️⚠️⚠️⚠️~
      使用模板前请认真阅读模板说明文档封面上的「用户协议」~
      😡👊模板作者不对使用本模板产生的格式审查问题负责👊😡~
      导言区添加全局选项 `I-agree'：
      `\documentclass[I-agree]{hduthesis}`~
      即可顺利编译✌️并代表您已同意本协议🥰~
      可反馈Issues至📮xiamyphys@gmail.com.~ 祝君科研顺利！
    }
  }

\cs_generate_variant:Nn \hduthesis_msg_error:nn { nx }
\hduthesis_msg_new:nn { not found module }
  { The~hduthesis~module~`#1'~not~found. }
\cs_new_protected_nopar:Npn \hduthesis_load_module:n #1 
  {
    \clist_map_inline:nn {#1}
    {
      \file_if_exist_input:nF { hduthesis-##1-module.code.tex }
        { \hduthesis_msg_error:nn { not found module } {##1} }
    }
  }
\cs_new_protected_nopar:Npn \hduthesis_provide_module:n #1
  {
    \ProvidesExplFile{hduthesis-#1-module.code.tex}
      {\hduthesis@date}{\hduthesis@version}
      {HDUThesis~ \text_titlecase:n {#1} ~Module}
  }

% global options
\clist_new:N \g__hdu_base_class_options_clist
\keys_define:nn { hduthesis / classoption }
  {
    I-agree .bool_set:N  = \g__hduthesis_agreement_bool,
      I-agree .initial:n = false,
      I-agree .default:n = true,
    math-font .tl_set:N     = \g__hduthesis_math_font,
    main-font .tl_set:N     = \g__hduthesis_main_font,
    sans-font .tl_set:N     = \g__hduthesis_sans_font,
    mono-font .tl_set:N     = \g__hduthesis_mono_font,
    CJKmain-font .tl_set:N  = \g__hduthesis_main_CJK_font,
    CJKsans-font .tl_set:N  = \g__hduthesis_sans_CJK_font,
    CJKmono-font .tl_set:N  = \g__hduthesis_mono_CJK_font,
    unknown .code:n         = \__hduthesis_unknown_option:n { #1 },
  }
\cs_new_protected_nopar:Npn \__hduthesis_unknown_option:n #1
  {
    \tl_if_empty:nTF { #1 }
      {
        \clist_gput_right:NV \g__hdu_base_class_options_clist \l_keys_key_str
      }
      {
        \exp_args:NNx \clist_gput_right:Nn \g__hdu_base_class_options_clist
          { \l_keys_key_str = \exp_not:n {#1} }
      }
  }

\ProcessKeyOptions[ hduthesis / classoption ]
\PassOptionsToClass{a4paper,zihao = -4}{ctexrep}
\PassOptionsToPackage{quiet,no-math}{xeCJK}
\exp_args:NNV \LoadClass[\g__hdu_base_class_options_clist]{ctexrep}
\bool_if:NF \g__hduthesis_agreement_bool
  { \hduthesis_msg_error:nn { 用户协议 } { 未确认 } }

\RequirePackage { siunitx, circuitikz, pgfplots, listings, hologo,
                  lipsum, zhlipsum, booktabs, multicol, hyperref }
\pgfplotsset{compat = newest}
\pdfstringdefDisableCommands
  {
    \def\cite#1{<#1>}
    \def\hologoRobust#1{<#1>}
  }

\hduthesis_load_module:n { font }
\hduthesis_load_module:n { unv.layout }

\keys_define:nn { hduthesis / docinfo }
  {
    title.clist_set:N      = \l__docinfo_title_clist,
    department.tl_set:N    = \l__docinfo_department_tl,
    major.tl_set:N         = \l__docinfo_major_tl,
    class.tl_set:N         = \l__docinfo_class_tl,
    stdntid.tl_set:N       = \l__docinfo_stdntid_tl,
    author.clist_set:N     = \l__docinfo_author_clist,
    supervisor.clist_set:N = \l__docinfo_supervisor_clist,
    bibsource.tl_set:N     = \l__docinfo_bibsource_tl,
  }
\clist_set:Nn \g_system_month_clist
  {
    January, February, March, April, May, June, July,
    August, September, October, November, December
  }
\NewDocumentCommand \DocInfo { m }
  {
    \keys_set:nn { hduthesis / docinfo } {#1}
    \exp_args:NNne \seq_set_split:Nnn
      \l__title_tmp_seq {/} {\l__docinfo_title_clist}
    \exp_args:NNe \tl_set:Nn
      \l__docinfo_cntitle_tl { \seq_item:Nn \l__title_tmp_seq {1} }
    \exp_args:NNe \tl_set:Nn
      \l__docinfo_entitle_tl { \seq_item:Nn \l__title_tmp_seq {2} }
    \exp_args:NNne \seq_set_split:Nnn
      \l__author_tmp_seq {/} {\l__docinfo_author_clist}
    \exp_args:NNe \tl_set:Nn
      \l__docinfo_cnauthor_tl { \seq_item:Nn \l__author_tmp_seq {1} }
    \exp_args:NNe \tl_set:Nn
      \l__docinfo_enauthor_tl { \seq_item:Nn \l__author_tmp_seq {2} }
    \exp_args:NNne \seq_set_split:Nnn
      \l__supervisor_tmp_seq {/} {\l__docinfo_supervisor_clist}
    \exp_args:NNe \tl_set:Nn
      \l__docinfo_cnsupervisor_tl { \seq_item:Nn \l__supervisor_tmp_seq {1} }
    \exp_args:NNe \tl_set:Nn
      \l__docinfo_ensupervisor_tl { \seq_item:Nn \l__supervisor_tmp_seq {2} }
    \bool_if:NF \g__hduthesis_agreement_bool
      { \tl_clear:N \l__docinfo_bibsource_tl }
    \tl_if_empty:NTF \l__docinfo_bibsource_tl
      {
        \newcommand*\printbibliography{\chapter*{参考文献}}
        \renewcommand*\cite[1]{\textsuperscript{[##1]}}
      }
      {
        \RequirePackage[sort&compress]{gbt7714}
        \bibliographystyle{gbt7714-numerical}
        \dim_set:Nn \bibsep {.35ex}
        \newcommand*\printbibliography
          { \nocite{*}\bibliography{ \l__docinfo_bibsource_tl } }
        \hook_gput_code:nnn { cmd/printbibliography/before } { . }
          {
            \group_begin:
            \hook_gput_code:nnn { cmd/@makeschapterhead/before } { . } { \null }
          }
        \hook_gput_code:nnn { cmd/printbibliography/after } { . }
          {
            \group_end:
            \addcontentsline{toc}{chapter}{参考文献}
          }
      }
    \hypersetup
      {
        hidelinks, pdftitle = \l__docinfo_entitle_tl,
        pdfauthor = \l__docinfo_enauthor_tl,
        pdfproducer = hduTeX~bundle~by~Mingyu~Xia,
      }
    \ExplSyntaxOn
      \int_compare:nNnTF { \tl_count:N \l__docinfo_stdntid_tl } = { 8 }
        { \hduthesis_load_module:n { bc.layout } }
        { \hduthesis_load_module:n { pg.layout } }
    \ExplSyntaxOff
  }

\endinput

% End of file hduthesis.cls
