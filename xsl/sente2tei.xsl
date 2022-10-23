<?xml version="1.0" encoding="UTF-8"?>
<!--
    Sente to tei
    
    @since 2017-07-14
    @version 0.1
    @author emchateau
    
    @note 
    &lt;sup&gt;e&lt;/sup&gt; vers <sup>e</sup>
    &amp;lt;sup&amp;gt;e&amp;lt;/sup&amp;gt; vers <sup>e</sup>
    C&amp;lt;sup&amp;gt;ie&amp;lt;/sup&amp;gt; vers C<sup>ie</sup> 
    &lt;sup&gt;21&lt;/sup&gt; vers <sup>21</sup>
    &amp;amp; vers &amp;
    &lt;br&gt;&lt;br&gt; vers <br/>
    &lt;br&gt; vers <br/>
    &lt;br&gt; vers <br/>
    &lt;b&gt; vers <b> etc. b i u
    &lt;a&gt; attention avec <a "href... 
    &quot;
    &lt;sup&gt; etc.
    
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.thirdstreetsoftware.com/SenteXML-1.0" 
    xmlns:saxon="http://saxon.sf.net/"
    xmlns="http://www.tei-c.org/ns/1.0">

    <xsl:output indent="yes" method="xml" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Bibliographie</title>
                    </titleStmt>
                    <publicationStmt>
                        <publisher/>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Converti depuis XSL, <xsl:copy-of select="current-dateTime()"/></p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:apply-templates/>
                </body>
            </text>
        </TEI>
    </xsl:template>

    <xsl:template match="senteContainer | library">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="library/references">
        <listBibl>
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>

    <xsl:template match="reference">
        <biblStruct>
            <xsl:choose>
                <xsl:when test="publicationType[@name = 'Journal Article']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'j'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="publicationType[@name = 'Catalog Chapter']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'a'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="publicationType[@name = 'Catalog']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'m'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="publicationType[@name = 'Report']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'m'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="publicationType[@name = 'Conference proceedings']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'a'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="publicationType[@name = 'Thesis type']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'t'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="publicationType[@name = 'Web page']">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'m'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="reference">
                        <xsl:with-param name="type" select="'default'"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </biblStruct>
    </xsl:template>
    <!-- Other, Unknown Book, Unpublished work, Electronic citation, Videotape, Maps, Data file, (null) -->
    
    <xsl:template name="reference">
        <xsl:param name="type"/>
        <xsl:if test="$type='j' and characteristics/characteristic[@name='articleTitle']">
            <analytic>
                <xsl:apply-templates select="authors/author[@role='Author']"/>
                <xsl:apply-templates select="characteristics/characteristic[@name='articleTitle']"/>
            </analytic>
        </xsl:if>
        
        <xsl:call-template name="monogr">
            <xsl:with-param name="type" select="$type"/>
        </xsl:call-template>
        
        <xsl:apply-templates select="characteristics/characteristic[@name='ISBN']"/>
        <xsl:apply-templates select="characteristics/characteristic[@name='DOI']"/>
        <xsl:apply-templates select="characteristics/characteristic[@name='URL']"/>
    </xsl:template>
    
   <xsl:template name="monogr">
       <xsl:param name="type"/>
       <monogr>
           <xsl:choose>
               <xsl:when test="$type='j'">
                   <xsl:apply-templates select="characteristics/characteristic[@name='publicationTitle']" mode="j"/>
                   <xsl:apply-templates select="characteristics/characteristic[@name='Secondary title']" mode="j"/>
               </xsl:when>
               <xsl:when test="$type='t'">
                   <xsl:apply-templates select="characteristics/characteristic[@name='articleTitle']" mode="t"/>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:apply-templates select="authors/author[@role='Author']"/>
                   <xsl:apply-templates select="characteristics/characteristic[@name='publicationTitle']" mode="m"/>
                   <xsl:apply-templates select="characteristics/characteristic[@name='Secondary title']" mode="m"/>
               </xsl:otherwise>
           </xsl:choose>
           <xsl:apply-templates select="charecteristics/characteristic[@name='description']"/>
           <xsl:apply-templates select="charecteristics/characteristic[@name='Meeting']"/>
           <xsl:apply-templates select="authors/author[@role='Editor']"/>
           <xsl:apply-templates select="authors/author[@role='Director']"/>
           <xsl:apply-templates select="authors/author[@role='Translator']"/>
           <xsl:apply-templates select="characteristics/characteristic[@name='ISSN']"/>
           <imprint>
               <xsl:apply-templates select="characteristics/characteristic[@name='publisher']"/>
               <xsl:apply-templates select="characteristics/characteristic[@name='affiliation']"/>
               <xsl:apply-templates select="characteristics/characteristic[@name='publicationCountry']"/>
               <xsl:apply-templates select="characteristics/characteristic[@name='volume']"/>
               <xsl:apply-templates select="characteristics/characteristic[@name='issue']"/>
               <xsl:apply-templates select="dates"/>
               <xsl:apply-templates select="characteristics/characteristic[@name='pages']"/>
           </imprint>
       </monogr>
   </xsl:template>
    
    
    <!-- names and responsability -->
    
    <xsl:template match="authors/author[@role='Author']">
        <author>
            <xsl:apply-templates/>
        </author>
    </xsl:template>
    <xsl:template match="authors/author[@role='Editor']">
        <!-- @todo distinct for dir -->
        <editor>
            <xsl:apply-templates/>
        </editor>
    </xsl:template>
    <xsl:template match="authors/author[@role='Director']">
        <!-- @todo distinct for dir -->
        <respStmt>
            <resp>directeur</resp>
            <persName>
                <xsl:apply-templates/>
            </persName>
        </respStmt>
    </xsl:template>
    <xsl:template match="authors/author[@role='Translator']">
        <!-- @todo distinct for dir -->
        <respStmt>
            <resp>traducteur</resp>
            <persName>
                <xsl:apply-templates/>
            </persName>
        </respStmt>
    </xsl:template>
    <xsl:template match="forenames">
        <forename>
            <xsl:apply-templates/>
        </forename>
    </xsl:template>
    <xsl:template match="surname">
        <surname>
            <xsl:apply-templates/>
        </surname>
    </xsl:template>
    <xsl:template match="initials"/>

    <!-- titles parts -->
    
    <xsl:template match="characteristic[@name='articleTitle']">
        <title level="a">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <!-- @rmq @level=t isn’t specified in TEI -->
    <xsl:template match="characteristic[@name='articleTitle']" mode="t">
        <title level="t">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='publicationTitle']" mode="#all">
        <xsl:variable name="mode" select="saxon:current-mode-name()"/>
        <xsl:choose>
            <xsl:when test="following-sibling::characteristic[@name='Secondary title']">
                <title level="{$mode}" type="main">
                    <xsl:apply-templates/>
                </title>
            </xsl:when>
            <xsl:otherwise>
                <title level="{$mode}">
                    <xsl:apply-templates />
                </title>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='Secondary title']" mode="#all">
        <xsl:variable name="mode" select="saxon:current-mode-name()"/>
        <title level="{$mode}" type="sub">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='Meeting']">
        <meeting>
            <xsl:apply-templates/>
        </meeting>
    </xsl:template>
    
    <!-- imprint -->
    <xsl:template match="characteristic[@name='publisher']">
        <publisher>
            <xsl:apply-templates/>
        </publisher>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='publicationCountry']">
        <pubPlace>
            <xsl:apply-templates/>
        </pubPlace>
    </xsl:template>
    
    <xsl:template match="characteristics/characteristic[@name='affiliation']">
        <!-- @todo faute de mieux pour les thèses -->
        <distributor>
            <xsl:apply-templates/>
        </distributor>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='issue']">
        <biblScope unit="issue">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='volume']">
        <biblScope unit="volume">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    
    
    <!-- @todo add two digit for months -->
    <!-- @todo enhance working with sequences -->
    <xsl:template match="dates/date">
        <xsl:variable name="year" select="format-number(@year, '####')"/>
        <xsl:if test="@month">
            <xsl:variable name="month" select="format-number(@month, '##')"/>
        </xsl:if>
        <xsl:if test="@day">
            <xsl:variable name="day" select="format-number(@day, '##')"/>
        </xsl:if>
        <xsl:variable name="date" select="@year | @month | @day"/>
        <date when="{string-join(($date), '-')}">
            <xsl:value-of select="string-join( ($date), '-')"/>
        </date>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='pages']">
        <biblScope unit="page">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    
    <!-- ids -->
    
    <xsl:template match="characteristic[@name='ISBN']">
        <idno type="isbn">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='ISSN']">
        <idno type="issn">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='DOI']">
        <idno type="doi">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
    <xsl:template match="characteristic[@name='URL']">
        <xsl:variable name="url" select="."/>
        <ref target="{$url}">
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    
    <!-- typographical output -->
    
    <xsl:template match="sup">
        <hi rend="superscript">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="i">
        <hi rend="italic">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="b">
        <hi rend="bold">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <!-- Copie à l'identique du fichier (toutes les passes) -->
    <!--<xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>-->
    
    <!-- 
    status
    UUID
    call-num
    database
    source-app
    EndNote reference number
    Citation identifier
    publicationStatus
    abstractText
    RIS reference number
    rating
    Web data source
    URL
    Medium
    affiliation
    language
    All ISBNs
    US LoC Call #
    US LoC Control #
    GoogleBooks key
    BibTeX cite tag
    OCLCID
    Medium consulted
    Copyright
    JSTOR ID
    jstor formatteddate
    Meeting
    Collection description
    Series number
    Series
    Description
    section
    Google Scholar BibTeX export key
    research-notes
    Edition
    jstor articletype
    audience
    Caption
    OAI
    HAL ID
    Alternate title
    Shortened title
    Number of volumes
    custom1
    num-vols
    Publisher's imprint
    jstor issuetitle
    Library-Id
    Date-Added
    Call-Number
    Date-Modified
    GCA ID
    work-type
    day
    Original publication
    Address
    HAL VERSION
    PDF
    Series volume
    Physical description
    electronic-resource-num
    Bdsk-Url-1
    shorttitle
    Dewey Decimal Classification
    Dewey-Call-Number
    Genre
    Library of Congress Classification
     -->

</xsl:stylesheet>
