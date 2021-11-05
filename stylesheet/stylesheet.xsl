<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="bs:roster/bs:forces">
    <html>
		<head>
			<style>
            /* @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@500&amp;display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Lusitana&amp;display=swap'); */
            @import url('https://fonts.googleapis.com/css2?family=Kanit:wght@200&amp;family=Orbitron&amp;family=Russo+One&amp;display=swap');

            /* @media print{@page {size: landscape}} */

            @media (orientation: landscape) {
                body {
                    font-family: 'Kanit', sans;
                    font-size: 0.8em; 
                    flex-direction: column;
                }

                h1 {
                    font-family: 'Russo One', sans;
                    /* font-size: 54pt; */
                    font-weight: bold;
                    margin-bottom: 0;
                    display: inline-block;
                }
                h2 {
                    font-family: 'Russo One', sans;
                    /* font-size: 54pt; */
                    margin-top: 0;
                    font-weight: normal;
                    display: inline-block;
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
                    min-height: 2.1cm;
                    background-color: #ffffff;
                    /* border: 2px solid #555555;
                    border-radius: 0.4em; */
                    border: 6px solid transparent;
                    padding: 5px;
                    border-image: url(https://www.worldanvil.com/uploads/images/570410efbb0c11476af474932082da6c.png) 10 stretch;
                    margin-bottom: 0;
                    font-size: 0.8em; 
                    page-break-inside: avoid;
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


                .card .wound-track {
                    height: 2.5cm;
                    width: 5cm;
                    float: right;
                    z-index: 1;
                    position: absolute;
                    margin-left: 10.2cm;
                    background-color: white;
                    border: 2px solid #555555;
                    border-bottom-left-radius: 0.4em;
                    border-bottom-right-radius: 0.4em; }
                .card .wound-track span {
                    color: #FF0000;
                    font-weight: bold; }
                .card .wound-track .wound-track-header {
                    padding: 2px 4px;
                    font-size: 0.6em; }
                .card .wound-track table {
                    width: 100%;
                    font-size: 0.7em;
                    border-collapse: collapse;
                    text-align: center; }


                /* .card .wound-track tr {
                    background-color: #FFFFFF; }
                .card .wound-track tr:nth-child(odd) {
                    background-color: #AFB7A4; }
                .card .wound-track tr::nth-child(even) {
                    background-color: #FFFFFF; }
                .card .wound-track th {
                    background-color: #748A4E; } */


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
                    border-left: 2px solid #004466;   
                }
                table.stats td:first-child { 
                    border-left: none;
                }
                table.stats tr:nth-child(odd) {
                    font-weight: bold; 
                    font-size: 0.4em;
                    border-bottom: 2px solid #004466;  
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
                    margin-right: 2px;
                }
                .hitbox:first-of-type {
                    margin-top: 12px;
                    margin-left: 8px;
                }
                .hitbox:nth-child(3n+2) {
                    background-color: #10909e;
                }


                .gear {
                    color: black;
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
        <h1><xsl:value-of select="../@name"/> - </h1>
        <h2>A Cabal of <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/@name"/> Demons</h2>
    </section>

    <section class="roster-body">
        <p><b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[3]/@name"/>: </b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[3]/bs:characteristics/bs:characteristic"/> </p>
        <p><b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[2]/@name"/>: </b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[2]/bs:characteristics/bs:characteristic"/> </p>
    </section>
    
    <section id="roster-footer" class="roster-footer">    
    </section>
</xsl:template>

<!-- CARD STUFF? !-->
<xsl:template match="bs:force/bs:selections" mode="cards">
    
	<xsl:apply-templates select="bs:selection[@type='model']">
        <!-- <xsl:sort data-type="number" select="string-length(substring-before($sortOrder, @result))" /> -->
        <xsl:sort select="bs:categories/bs:category[@entryId='0894-68fa-8134-6e32' or @entryId='3436-8e6e-a8f6-716e' or @entryId='e534-8b74-6056-9e87']/@name" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="bs:selection[@type='model']">
	<div class="card">
			
        <xsl:variable name="stats" select="bs:profiles/bs:profile/bs:characteristics" />
        <xsl:variable name="gear" select="bs:profiles/bs:profile[@typeName='Armour' or @typeName='Weapon' or @typeName='Equipment']" />
        <!-- Captain and 1st Mate Gear Path -->
        <xsl:variable name="leader-gear" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Armour' or @typeName='Weapon' or @typeName='Equipment']" />
        <xsl:variable name="powers" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Power']" />

		<div class="card-body">

            <div class="card-header" style="align: left">
                <b><xsl:value-of select="./@name"/></b> - <xsl:value-of select="bs:categories/bs:category/@name"/>
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

                
            <!-- WOUND TRACKER !-->
            <b>Wounds:</b><xsl:call-template name="life-tracker" />

                
            <!-- DECLARE GEAR -->
            <p class="gear"> 
                <b>Gear: </b>
                    <xsl:for-each select="$gear">
                        <xsl:value-of select="@name"/>, 
                    </xsl:for-each>
            </p>

                
            <!-- DECLARE POWERS 
                 => change to Powers later -->
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
        </div>
	</div>
</xsl:template>

<xsl:template name="life-tracker">
    <xsl:variable name="hp" select="bs:profiles/bs:profile/bs:characteristics/bs:characteristic[@name='H']" />
    <xsl:param name="index" select="1" />
    <xsl:param name="maxValue" select="$hp" />

    <div class="hitbox"></div>
    
    <!-- &lt; represents "<" for html entities -->
    <xsl:if test="$index &lt; $maxValue">
        <xsl:call-template name="life-tracker">
            <xsl:with-param name="index" select="$index + 1" />
            <xsl:with-param name="maxValue" select="$maxValue" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>