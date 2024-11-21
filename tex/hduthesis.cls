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
%%                                    hduthesis-typeset-module.code,     *
%%                                    hduthesis-layout-module.code,      *
%%                                    hduthesis-bc.config-module.code,   *
%%                                    hduthesis-pg.config-module.code,   *
%%                                    hduthesis-hdu.l3doc-module.code,   *
%%                                and README.md.                         *
%%    available at https://github.com/xiamyphys/hduthesis                *
%% ***********************************************************************
\def\hduthesis@date{2024/11/22}
\def\hduthesis@version{0.3.4}

\RequirePackage{etoolbox}
\ProvidesExplClass{hduthesis} {\hduthesis@date} {\hduthesis@version}
  {LaTeX Class for Thesis at Hangzhou Dianzi University}

\cs_new_protected:Npn \hduthesis_msg_new:nn #1#2 
  { \msg_new:nnn { hduthesis } {#1} {#2} }
\cs_new_protected:Npn \hduthesis_msg_error:nn #1#2
  { \msg_error:nnn { hduthesis } {#1} {#2} }

\hduthesis_msg_new:nn { 用户协议 }
  { \exp_not:n
    {
      ⚠️⚠️⚠️⚠️⚠️~     「hduThesiS」编译受阻🥵     ~⚠️⚠️⚠️⚠️⚠️~
      使用模板前请认真阅读模板说明文档封面上的「用户协议」~
      😡👊模板作者不对使用本模板产生的格式审查问题负责👊😡~
      添加选项 `agreed'[\documentclass[agreed]{hduthesis}]~
      即可顺利编译并默认代表您已同意本协议.~ 祝君科研顺利！~
      如遇问题，可邮件反馈至📮xiamyphys@gmail.com.
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
      {hduThesiS~ \text_titlecase:n {#1} ~Module}
  }

% global options
\clist_new:N \g__hdu_base_class_options_clist
\keys_define:nn { hduthesis / classoption }
  {
    agreed .bool_set:N      = \g__hduthesis_agreement_bool,
      agreed .initial:n     = false,
      agreed .default:n     = true,
    l3doc .bool_set:N       = \g__hduthesis_doc_bool,
      l3doc .initial:n      = false,
      l3doc .default:n      = true,
    math-font .tl_set:N     = \g__hduthesis_math_font,
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
\ProcessKeyOptions [ hduthesis / classoption ]

\bool_if:NT \g__hduthesis_doc_bool
  {
    \PassOptionsToClass{ 11pt, letterpaper } { l3doc }
    \exp_args:NNV \LoadClass [ \g__hdu_base_class_options_clist ] { l3doc }
    \hduthesis_load_module:n { hdu.l3doc }
    \endinput
  }

\PassOptionsToClass { a4paper, zihao = -4 } { ctexrep }
\PassOptionsToPackage { quiet, no-math } { xeCJK }
\exp_args:NNV \LoadClass [ \g__hdu_base_class_options_clist ] { ctexrep }
\bool_if:NTF \g__hduthesis_agreement_bool
  {
    \RequirePackage{hyperref}
    \pdfstringdefDisableCommands
      {
        \def\cite#1{<#1>}
        \def\hologoRobust#1{<#1>}
      }
    \AtBeginDocument
      { \hypersetup { hidelinks, pdfproducer = hduThesiS~by~Mingyu~Xia } }
  } { \hduthesis_msg_error:nn { 用户协议 } { 未确认 } }

\RequirePackage { siunitx, circuitikz, pgfplots, listings,
                  hologo, lipsum, zhlipsum, booktabs, multicol }
\pgfplotsset { compat = newest }
\hduthesis_load_module:n { typeset }
\hduthesis_load_module:n { layout }
\cs_new_protected:Nn \__hduthesis_docinfo_degree_if_aux:
  {
    \int_compare:nNnTF { \tl_count:N \l__docinfo_stdntid_tl } = { 8 }
      { \hduthesis_load_module:n { bc.config } }
      { \hduthesis_load_module:n { pg.config } }
  }

\endinput

% End of file hduthesis.cls
