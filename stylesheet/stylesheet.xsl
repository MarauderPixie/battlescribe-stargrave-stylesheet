<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="bs:roster/bs:forces">
    <html>
		<head>
			<style>
            @import url('https://fonts.googleapis.com/css2?family=Kanit:wght@200&amp;family=Orbitron&amp;family=Russo+One&amp;display=swap');

            @media (orientation: landscape) {
                body {
                    font-family: 'Kanit', sans;
                    font-size: 1em; 
                    flex-direction: column;
                }

                h1,
                h2 {
                    font-family: 'Russo One', sans;
                    font-weight: bold;
                    margin-bottom: 0;
                    display: inline-block;
                }
                h2 {
                    font-weight: normal;
                }

                p {
                    padding: 5px 10px;
                    margin-block-start: 0em;
                    margin-block-end: 0em;
                }


                .card {
                    float: left;
                    margin: 12px;
                    width: 10cm;
                    min-height: 2cm;
                    background-color: #ffffff;
                    border: 6px solid transparent;
                    border-image: url(https://www.worldanvil.com/uploads/images/570410efbb0c11476af474932082da6c.png) 6 stretch;
                    padding: 5px;
                    margin-bottom: 0;
                    font-size: 0.8em; 
                    page-break-inside: avoid;
                    /* border: 2px solid #555555;
                    border-radius: 0.4em;
                    background-image: url(https://www.worldanvil.com/uploads/images/f45d9aa29ab661fdefa6881634c19c39.png); */
                }
                .card:nth-child(even) {
                    clear: left;
                }
                .card .card-header {
                    color: #000000;
                    font-size: 1.2em;
                    font-variant-caps: small-caps;
                    /* background-color: #f4f4f4; */
                    border-top-left-radius: 0.4em;
                    border-top-right-radius: 0.4em;
                    text-align: left;
                    /* text-transform: uppercase; */
                    padding: 0.2cm; 
                }


                /* stat table */
                table.stats {
                    font-family: Orbitron, sans;
                    text-align: center;
                    border-collapse: collapse;
                    margin: 1px 8px 8px 5px;
                    float: left;
                }
                table.stats tr {
                    font-size: 0.9em;
                    background-color: #fff; 
                }
                table.stats td {
                    border-left: 1px solid #004466;   
                }
                table.stats td:first-child { 
                    border-left: none;
                }
                table.stats tr:nth-child(odd) {
                    font-weight: bold; 
                    font-size: 8px;
                    border-bottom: 1px solid #004466;  
                }


                /* powers table */
                table.powers {
                    width: 100%;
                    font-family: Orbitron, sans;
                    text-align: center;
                    border-collapse: collapse;
                    margin: 1px 8px 8px 5px;
                }
                table.powers tr {
                    font-size: 0.9em;
                    background-color: #fff; 
                }
                table.powers th {
                    border-bottom: 2px solid;
                    border-left: 2px solid; 
                    border-color: #004466;
                }
                table.powers td {
                    font-size: 0.9em;
                    border-left: 2px solid #004466; 
                }
                table.powers tr th:first-of-type,
                table.powers tr td:first-of-type { 
                    text-align: left;
                    border-left: none;
                }


                .hitbox {
                    height: 12px;
                    width: 12px;
                    background-color: #fff;
                    border: 1px solid #555555;
                    display: inline-block;
                    margin: 2px;
                }
                .hitbox:first-of-type {
                    margin-left: 10px;
                }
                .hitbox:nth-child(3n+2) {
                    background-color: #10909e;
                }


                .wounds { 
                    min-height: 42px;
                }
                .gear {
                    color: black;
                    font-size: 0.9em;
                    min-height: 36px;
                }

                .column {
                    float: left;
                    padding: 0;
                }
                .left {
                    width: 60%;
                }
                .right {
                    width: 40%;
                }
                .row:after {
                    content: "";
                    display: table;
                    clear: both;
                }
            }
            </style>
		</head>
	
        <body>
			<xsl:call-template name="roster"/>
            <!-- evtl. lässt sich hier einiges abkürzen, wenn ich hinter bs:force noch
                 /bs:selections/bs:selection packe? !-->
			<xsl:apply-templates select="bs:force" mode="cards"/>
	    </body>
	</html>
	</xsl:template>


<!-- GENERAL CABAL STUFF !-->
<xsl:template name="roster">
    <section class="roster-header">
        <h1> <xsl:value-of select="../@name"/> </h1>
    </section>

    <section class="roster-body">
        <p> <i>lots of space for ships n stuff</i> </p>
    </section>
    
    <section id="roster-footer" class="roster-footer">    
    </section>
</xsl:template>

<!-- CARD STUFF? !-->
<xsl:template match="bs:force/bs:selections" mode="cards">
    
	<xsl:apply-templates select="bs:selection[@type='model']">
        <!-- <xsl:sort data-type="number" select="string-length(substring-before($sortOrder, @result))" /> -->
        <xsl:sort select="bs:categories/bs:category[@entryId='8749-37ea-6f9e-0824' or @entryId='16bf-5402-ac6a-dab3' or @entryId='13f2-16cf-e0bd-6624' or @entryId='12dd-f26c-ca77-721a']/@name" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="bs:selection[@type='model']">
	<div class="card">
			
        <xsl:variable name="stats" select="bs:profiles/bs:profile/bs:characteristics" />
        <xsl:variable name="gear" select="bs:profiles/bs:profile[@typeName='Armour' or @typeName='Weapon' or @typeName='Equipment']" />
        <!-- Captain and 1st Mate Paths -->
        <xsl:variable name="leader-gear" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Armour' or @typeName='Weapon' or @typeName='Equipment']" />
        <xsl:variable name="powers" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Power']" />

		<div class="card-body">
        
                    
            
                    <div class="card-header" style="align: left">
                        <b><xsl:value-of select="./@name"/></b> - <xsl:value-of select="bs:categories/bs:category[@entryId='8749-37ea-6f9e-0824' or @entryId='16bf-5402-ac6a-dab3' or @entryId='13f2-16cf-e0bd-6624' or @entryId='12dd-f26c-ca77-721a']/@name"/>
                        <span style="float: right">
                        <xsl:choose>
                            <xsl:when test="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']">
                                <b><xsl:value-of select="@customName"/> the <xsl:value-of select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']/@name"/> </b>
                            </xsl:when>
                            <xsl:otherwise>
                                <b><xsl:value-of select="@customName"/></b>
                            </xsl:otherwise>
                        </xsl:choose>
                        </span>
                    </div>

            <div class="row">
                <div class="column left">
                    <table class="stats" cellspacing="0">
                        <tr>
                            <td> Move </td>
                            <td> Fight </td>
                            <td> Shoot </td>
                            <td> Armour </td>
                            <td> Will </td>
                            <td> Health </td>
                        </tr>
                        <tr>
                            <td> <xsl:value-of select="$stats/bs:characteristic[@name='M']"/> </td>
                            <td> <xsl:value-of select="$stats/bs:characteristic[@name='F']"/> </td>
                            <td> <xsl:value-of select="$stats/bs:characteristic[@name='S']"/> </td>
                            <td> <xsl:value-of select="$stats/bs:characteristic[@name='A']"/> </td>
                            <td> <xsl:value-of select="$stats/bs:characteristic[@name='W']"/> </td>
                            <td> <xsl:value-of select="$stats/bs:characteristic[@name='H']"/> </td>
                        </tr>
                    </table>
                </div>

                <div class="column right">
                    <!-- WOUND TRACKER !-->
                    <span class="wounds">
                        <p><b>Wounds:</b> <xsl:call-template name="wound-tracker" /></p>
                    </span>
                </div>
            </div>
                    
                

                
            <!-- DECLARE GEAR -->
            <p class="gear"> 
                <b>Gear: </b>
                <xsl:choose>
                    <xsl:when test="bs:categories/bs:category[@name='First Mate' or @name='Captain']">
                        <xsl:for-each select="$leader-gear">
                            <xsl:value-of select="@name"/>,
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="$gear">
                            <xsl:value-of select="@name"/>, 
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </p>

                
            <!-- DECLARE POWERS -->
            <xsl:if test="bs:categories/bs:category[@name='First Mate' or @name='Captain']">
                <table class="powers" cellspacing="0">
                    <tr>
                        <th> Power </th>
                        <th> Activation </th>
                        <th> Strain </th>
                    </tr>
                    <xsl:for-each select="$powers">
                        <tr>
                            <td> <xsl:value-of select="../../@name"/> </td>
                            <td> <xsl:value-of select="bs:characteristics/bs:characteristic[@name='Activation']"/> </td>
                            <td> <xsl:value-of select="bs:characteristics/bs:characteristic[@name='Strain']"/> </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:if>
        </div>
	</div>
</xsl:template>

<xsl:template name="wound-tracker">
        <xsl:variable name="hp" select="bs:profiles/bs:profile/bs:characteristics/bs:characteristic[@name='H']" />
        <xsl:param name="index" select="1" />
        <xsl:param name="maxValue" select="$hp" />

        <span class="hitbox"></span>
        
        <!-- &lt; represents "<" for html entities -->
        <xsl:if test="$index &lt; $maxValue">
            <xsl:call-template name="wound-tracker">
                <xsl:with-param name="index" select="$index + 1" />
                <xsl:with-param name="maxValue" select="$maxValue" />
            </xsl:call-template>
        </xsl:if>
</xsl:template>

</xsl:stylesheet>