<#include "/WEB-INF/freemarker/include/imports.ftl">
<#-- @ftlvariable name="documents" type="java.util.List<org.hippoecm.hst.content.beans.standard.HippoBean>" -->
<#if documents??>
    <#list documents as document>
        <#if document.title??>
            <@hst.link var="link" hippobean=document />
        <article class="has-edit-button">
            <@hst.cmseditlink hippobean=document/>
            <h3><a href="${link}">${document.title}</a></h3>
            <#if document.introduction??>
                <p>${document.introduction}</p>
            </#if>
        </article>
        </#if>
    </#list>
</#if>