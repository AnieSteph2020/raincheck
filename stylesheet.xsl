<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<!--  -->
 <xsl:variable name="iconBaseUrl" select="'https://openweathermap.org/img/wn/'" />

 <xsl:template match="icon">
   
   <img>
     <xsl:attribute name="src">
       <xsl:value-of select="concat($iconBaseUrl, normalize-space(.), '@2x.png')" />
     </xsl:attribute>
   </img>
 </xsl:template>
<!--  -->


<!--  -->
<xsl:template match="/">
    <html>
    <title>Raincheck</title>
		<style type="text/css">
			h2 { text-indent: 50px; font-family: Arial; }
			p { text-indent: 50px; font-family: Arial; font-size: 12px; }
		</style>

		<table border="0" cellspacing="0" cellpadding="0" width="100%" 
		bgcolor="#011627" >
			<tr>
				<td align="center" width="954" height="70"></td>
			</tr>
		</table>

            <body bgcolor="#fdfffc">
                <table align="center" text-align="center">
                    <tr>
                        <th>
                            <h2>
                                Ort
                            </h2>
                        </th>
                        <th>
                            <h2>
                                Aktuelles Wetter
                            </h2>
                        </th>
                    </tr>
                    <tr>
                        <td>

                            <p>
                                Latitude:
                                <xsl:value-of select="root/lat" />
                            </p>
                            <p>
                                Longitude:
                                <xsl:value-of select="root/lon" />
                            </p>
                            <p>
                                Zeitzone:
                                <xsl:value-of select="root/timezone" />
                            </p>             
						 </td>
                        <td>
                            
                            <p>
                                Temperatur:
                                <xsl:value-of select="root/current/temp" />
                                °C
                            </p>
                            <p>
                                Luftfeuchtigkeit:
                                <xsl:value-of select="root/current/humidity" />
                                %
                            </p>
                            <p>
                                Windgeschwindigkeit:
                                <xsl:value-of select="root/current/wind_speed" />
                                m/s
                            </p>
                            <p>
                                Wetter:
                                <xsl:value-of select="root/current/weather/description" />
                            </p>
                            
                        </td>
                    </tr>
                </table>

                <p align="center">
                    <xsl:apply-templates select="root/current/weather/icon" />
                </p>
                <h2 align="center">
                    Regenvorhersage

                </h2>
                <xsl:choose>
					<!-- Niederschlag >=1.4mm/h  -->
                    <xsl:when test="count(root/minutely[precipitation >= 1.4]) > 0">
                        <p align="center">
                            Es wird regnen! ☔
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <p align="center">
                            Es gibt keinen Regen! 🌂
                        </p>
                    </xsl:otherwise>
                </xsl:choose>
				<xsl:variable name="maxPrecipitation">
      <xsl:for-each select="//precipitation">
        <xsl:sort select="number(.)" data-type="number" order="descending"/>
        <xsl:if test="position() = 1">
          <xsl:value-of select="."/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <!-- Gib den höchsten Wert für precipitation aus -->
    <p align="center">Niederschlag: </p>
    <p align="center"><xsl:value-of select="$maxPrecipitation"/> mm/h</p>
            </body>
			<table border="0" cellspacing="0" cellpadding="0" width="100%" height="10%"
		bgcolor="#2ec4b6" >
		<tr>
			<td align="center" width="954" height="30"></td>
			
		</tr>
	</table>
        </html>
    </xsl:template>
</xsl:stylesheet>
