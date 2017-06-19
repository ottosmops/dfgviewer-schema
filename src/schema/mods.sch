<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="deu">
  <title>Regeln für das MODS-Anwendungsprofil des DFG-Viewer</title>
  <ns prefix="mods" uri="http://www.loc.gov/mods/v3"/>
  <pattern>
    <rule context="mods:*[not(mods:*)]">
      <assert test="normalize-space()">
        Das Element <value-of select="name()"/> muss Text enthalten.
      </assert>
    </rule>
  </pattern>
</schema>
