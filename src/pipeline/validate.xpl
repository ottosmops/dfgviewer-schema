<?xml version="1.0" encoding="utf-8"?>
<p:pipeline version="1.0" xml:base=".."
            xmlns:p="http://www.w3.org/ns/xproc"
            xmlns:d="https://github.com/dmj/dfgviewer-schema"
            xmlns:dv="http://dfg-viewer.de/"
            xmlns:mets="http://www.loc.gov/METS/"
            xmlns:mods="http://www.loc.gov/mods/v3"
            xmlns:oai="http://www.openarchives.org/OAI/2.0/">

  <p:declare-step type="d:dispatch-validation">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:choose>
      <p:when test="/oai:OAI-PMH">
        <d:validate-oai/>
      </p:when>
      <p:when test="/mets:mets">
        <d:validate-mets/>
      </p:when>
      <p:when test="/mods:mods">
        <d:validate-mods/>
      </p:when>
      <p:when test="/dv:links">
        <p:validate-with-relax-ng>
          <p:input port="schema">
            <p:document href="schema/dvlinks.rng"/>
          </p:input>
        </p:validate-with-relax-ng>
      </p:when>
      <p:when test="/dv:rights">
        <p:validate-with-relax-ng>
          <p:input port="schema">
            <p:document href="schema/dvrights.rng"/>
          </p:input>
        </p:validate-with-relax-ng>
      </p:when>
    </p:choose>
  </p:declare-step>

  <p:declare-step type="d:validate-mets">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:validate-with-xml-schema>
      <p:input port="schema">
        <p:document href="http://www.loc.gov/standards/mets/mets.xsd"/>
      </p:input>
    </p:validate-with-xml-schema>

    <p:validate-with-schematron>
      <p:log port="report"/>
      <p:input port="schema">
        <p:document href="schema/mets.sch"/>
      </p:input>
      <p:input port="parameters">
        <p:empty/>
      </p:input>
    </p:validate-with-schematron>

    <p:viewport match="mods:mods | dv:links | dv:rights">
      <d:dispatch-validation/>
    </p:viewport>

  </p:declare-step>

  <p:declare-step type="d:validate-mods">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:validate-with-xml-schema>
      <p:input port="schema">
        <p:document href="http://www.loc.gov/standards/mods/v3/mods.xsd"/>
      </p:input>
    </p:validate-with-xml-schema>

  </p:declare-step>

  <p:declare-step type="d:validate-oai">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:filter select="//oai:metadata/*"/>
    <d:dispatch-validation/>
  </p:declare-step>

  <d:dispatch-validation/>

</p:pipeline>
