<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:iso="http://www.iso.org/ns/1.0"
  xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
  xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:rel="http://schemas.openxmlformats.org/package/2006/relationships"
  xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
  xmlns:v="urn:schemas-microsoft-com:vml"
  xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
  xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
  xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
  xmlns:w10="urn:schemas-microsoft-com:office:word"
  xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:its="http://www.w3.org/2005/11/its"
  xmlns:tbx="http://www.lisa.org/TBX-Specification.33.0.html" version="2.0"
  exclude-result-prefixes="#all">
  <!-- import base conversion style -->

  <xsl:import href="../../../docx/from/docxtotei.xsl"/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
    <desc>
      <p> TEI stylesheet for simplifying TEI ODD markup </p>
      <p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		


Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p>
      <p>Author: See AUTHORS</p>

      <p>Copyright: 2013, TEI Consortium</p>
    </desc>
  </doc>


  <doc type="function" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Defines whether or not a word paragraph is a first level heading 
    </desc>
  </doc>

  <xsl:function name="tei:isFirstlevel-heading" as="xs:boolean">
    <xsl:param name="p"/>
    <xsl:variable name="s" select="$p/w:pPr/w:pStyle/@w:val"/>
    <xsl:choose>
      <xsl:when test="$s = 'heading 1'">true</xsl:when>
      <xsl:when test="$s = 'Heading 1'">true</xsl:when>
      <xsl:when test="$s = 'Heading1'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 1'">true</xsl:when>
      <xsl:when test="$s = 'Titre'">false</xsl:when>
      <xsl:when test="$s = 'Sous-titre'">false</xsl:when>
      <xsl:when test="$s = 'Titre 1'">true</xsl:when>
      <xsl:when test="$s = 'ITLP H1'">true</xsl:when>
      <xsl:when test="$s = 'ITLP Anonymous Heading 1'">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:function>


  <doc type="function" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Defines whether or not a word paragraph is a  heading 
    </desc>
  </doc>

  <xsl:function name="tei:is-heading" as="xs:boolean">
    <xsl:param name="p"/>
    <xsl:variable name="s" select="$p/w:pPr/w:pStyle/@w:val"/>
    <xsl:choose>
      <xsl:when test="$s = ''">false</xsl:when>
      <xsl:when test="starts-with($s, 'heading')">true</xsl:when>
      <xsl:when test="starts-with($s, 'Heading')">true</xsl:when>
      <xsl:when test="starts-with($s, 'Sous-section')">true</xsl:when>
      <xsl:when test="starts-with($s, 'sous-section')">true</xsl:when>
      <xsl:when test="starts-with($s, 'Titre')">true</xsl:when>
      <xsl:when test="starts-with($s, 'titre')">true</xsl:when>
      <xsl:when test="$s = 'ITLP Anonymous Heading 1'">true</xsl:when>
      <xsl:when test="$s = 'ITLP Anonymous Heading 2'">true</xsl:when>
      <xsl:when test="$s = 'ITLP H1'">true</xsl:when>
      <xsl:when test="$s = 'ITLP H2'">true</xsl:when>
      <xsl:when test="$s = 'ITLP H3'">true</xsl:when>
      <xsl:when test="$s = 'Heading1'">true</xsl:when>
      <xsl:when test="$s = 'Heading2'">true</xsl:when>
      <xsl:when test="$s = 'Heading3'">true</xsl:when>
      <xsl:when test="$s = 'Heading4'">true</xsl:when>
      <xsl:when test="$s = 'Heading5'">true</xsl:when>
      <xsl:when test="$s = 'Heading6'">true</xsl:when>
      <xsl:when test="$s = 'Heading7'">true</xsl:when>
      <xsl:when test="$s = 'Heading8'">true</xsl:when>
      <xsl:when test="$s = 'Heading9'">true</xsl:when>
      <xsl:when test="$s = 'heading 1'">true</xsl:when>
      <xsl:when test="$s = 'heading 2'">true</xsl:when>
      <xsl:when test="$s = 'heading 3'">true</xsl:when>
      <xsl:when test="$s = 'heading 4'">true</xsl:when>
      <xsl:when test="$s = 'heading 5'">true</xsl:when>
      <xsl:when test="$s = 'heading 6'">true</xsl:when>
      <xsl:when test="$s = 'heading 7'">true</xsl:when>
      <xsl:when test="$s = 'heading 8'">true</xsl:when>
      <xsl:when test="$s = 'heading 9'">true</xsl:when>
      <xsl:when test="$s = 'Titre 1'">true</xsl:when>
      <xsl:when test="$s = 'Titre 2'">true</xsl:when>
      <xsl:when test="$s = 'Titre 3'">true</xsl:when>
      <xsl:when test="$s = 'Titre 4'">true</xsl:when>
      <xsl:when test="$s = 'Titre 5'">true</xsl:when>
      <xsl:when test="$s = 'Titre 6'">true</xsl:when>
      <xsl:when test="$s = 'Titre 7'">true</xsl:when>
      <xsl:when test="$s = 'Titre 8'">true</xsl:when>
      <xsl:when test="$s = 'Titre 9'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 1'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 2'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 3'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 4'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 5'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 6'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 7'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 8'">true</xsl:when>
      <xsl:when test="$s = 'Sous-section 9'">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="tei:heading-level" as="xs:string">
    <xsl:param name="p"/>
    <xsl:analyze-string select="$p/w:pPr/w:pStyle/@w:val" regex="[^0-9]*([0-9])">
      <xsl:matching-substring>
        <xsl:value-of select="number(regex-group(1))"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:text>1</xsl:text>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>

  <doc type="function" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Is given a header style and returns the style for the next level
      header 
    </desc>
  </doc>

  <xsl:function name="tei:get-nextlevel-header" as="xs:string">
    <xsl:param name="current-header"/>
    <xsl:value-of select="translate($current-header, '12345678', '23456789')"/>
  </xsl:function>


  <doc type="function" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Override default behaviour for a styled paragraph</desc>
  </doc>

  <xsl:template match="w:p[w:pPr/w:pStyle/@w:val = 'Corps']" mode="paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="w:p[w:pPr/w:pStyle/@w:val = 'Texte Courant']" mode="paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="w:p[w:pPr/w:pStyle/@w:val = 'Texte 1er §']" mode="paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:p[tei:match(@rend, 'Quote')]" mode="pass2">
    <quote>
      <p>
        <xsl:apply-templates mode="pass2"/>
      </p>
    </quote>
  </xsl:template>


<!--  <!-\- jiggle around the paragraphs which should be in front -\->
  <xsl:template match="tei:text" mode="pass3">
    <text>
      <front>
        <titlePage>
          <docTitle>
            <titlePart type="main">
              <xsl:for-each select="//tei:p[tei:match(@rend, 'Titre')]/node()">
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </titlePart>
            <titlePart type="sub">
              <xsl:for-each select="//tei:p[tei:match(@rend, 'Sous-Titre')]/node()">
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </titlePart>
          </docTitle>
          <docAuthor>
            <xsl:for-each select="//tei:p[tei:match(@rend, 'author')]/node()">
              <xsl:copy-of select="."/>
            </xsl:for-each>
          </docAuthor>
        </titlePage>
      </front>
      <body>
        <xsl:apply-templates mode="pass3" select="tei:body/*"/>
      </body>
    </text>
  </xsl:template>

  <!-\- suppress paragraphs which have been jiggled into front/back -\->

  <xsl:template match="tei:p[tei:match(@rend, 'Titre')]" mode="pass3"/>
  <xsl:template match="tei:p[tei:match(@rend, 'Sous-Titre')]" mode="pass3"/>


  <!-\- and copy everything else -\->

  <xsl:template match="@* | comment() | processing-instruction() | text()" mode="pass3">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="*" mode="pass3">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"
        mode="pass3"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="tei:TEI" mode="pass2">
    <xsl:variable name="Doctext">
      <xsl:copy>
        <xsl:apply-templates mode="pass2"/>
      </xsl:copy>
    </xsl:variable>
    <xsl:apply-templates select="$Doctext" mode="pass3"/>
  </xsl:template>-->

</xsl:stylesheet>
