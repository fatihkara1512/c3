<cfcomponent>
  <cffunction name="ekle" access="remote"  returnFormat = "plain" >
    <cfargument name="isim" type="string" required="false" />
    <cfargument name="soyisim" type="string" required="false" />
    <cfargument name="tel" type="string" required="false" />
    <cfargument name="email" type="string" required="false" />
    <cfargument name="adres" type="string" required="false" />
    <cftry>
    <cfquery name="y"  datasource="veritabani">
 INSERT INTO bilgiler (isim,soyisim,telefon,mail,adres)
 OUTPUT INSERTED.*
VALUES ('#isim#','#soyisim#','#tel#','#email#','#adres#');
    </cfquery>
    <cfset sonuc="Başarılı|"&y.id&"|"&y.isim&"|"&y.soyisim&"|"&y.telefon&"|"&y.mail&"|"&y.adres >
    <cfcatch type="any">
        <cfset sonuc="Başarısız" >
    </cfcatch>
</cftry>
    <cfreturn sonuc />
</cffunction>

  <cffunction name="sil" access="remote"  returnFormat = "plain" >
    <cfargument name="id" type="string" required="false" />
    <cfquery name="y"  datasource="veritabani">
 DELETE FROM bilgiler WHERE id=#id#;
    </cfquery>
</cffunction>

  <cffunction name="goster" access="remote"  returnFormat = "plain" >
    <cfargument name="id" type="string" required="false" />
    <cfquery name="y"  datasource="veritabani">
 SELECT * FROM bilgiler WHERE id=#id#;
    </cfquery>
    <cfset sonuc="Başarılı|"&y.id&"|"&y.isim&"|"&y.soyisim&"|"&y.telefon&"|"&y.mail&"|"&y.adres >
    <cfreturn sonuc />
</cffunction>
<cffunction name="guncelle" access="remote"  returnFormat = "plain" >
    <cfargument name="id" type="string" required="false" />
    <cfargument name="isim" type="string" required="false" />
    <cfargument name="soyisim" type="string" required="false" />
    <cfargument name="tel" type="string" required="false" />
    <cfargument name="email" type="string" required="false" />
    <cfargument name="adres" type="string" required="false" />
    <cftry>
    <cfquery name="y"  datasource="veritabani">
    UPDATE bilgiler
SET isim = '#isim#', soyisim= '#soyisim#',telefon='#tel#',mail='#email#',adres='#adres#'
WHERE id = #id#;
    </cfquery>
    <cfset sonuc="Başarılı|"&#id#&"|"&#isim#&"|"&#soyisim#&"|"&#tel#&"|"&#email#&"|"&#adres# >
    <cfcatch type="any">
        <cfset sonuc="Başarısız" >
    </cfcatch>
</cftry>
    <cfreturn sonuc />
</cffunction>
</cfcomponent>


