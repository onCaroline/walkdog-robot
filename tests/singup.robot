*** Settings ***
Documentation    Suit de testes do cadastro do site walkdog
Library    Browser

*** Test Cases ***
Deve conseguir preencher todo o formulario com sucesso 
 
    ${dogWalker}    Create Dictionary    
    ...    name=Caroline Nunes 
    ...    email=caroline.nunes@uorak.com
    ...    cpf=33681146381
    ...    cep=07111150
    ...    addressStreet=Rua João Zacharias
    ...    addressNumber=123
    ...    addressDetails=casa principal
    ...    addressDistrict=Vila Camargos
    ...    addressCityUf=Guarulhos/SP
    ...    rgRobertaPardo=roberta_pardo.jpg

    Go to signup page
    Fill signup form    ${dogWalker} 
    Sleep    10 
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.


***Keywords***
Go to signup page
    New Browser    browser=chromium    headless=False
    New Page    https://walkdog.vercel.app/signup
    Wait For Elements State    form h1    visible    5000
    Get Text    form h1    equal    Faça seu cadastro

Fill signup form
    [Arguments]    ${dogWalker} 
    Fill Text    css=input[name=name]              ${dogWalker}[name] 
    Fill Text    css=input[name=email]             ${dogWalker}[email] 
    Fill Text    css=input[name=cpf]               ${dogWalker}[cpf] 
    Fill Text    css=input[name=addressNumber]     ${dogWalker}[addressNumber] 
    Fill Text    css=input[name=addressDetails]    ${dogWalker}[addressDetails] 
    Fill Text    css=input[name=cep]               ${dogWalker}[cep] 

    Click        css=input[type=button][value="Buscar CEP"] 

    Get Property    css=input[name=addressStreet]       value    equal    ${dogWalker}[addressStreet] 
    Get Property    css=input[name=addressDistrict]     value    equal    ${dogWalker}[addressDistrict] 
    Get Property    css=input[name=addressCityUf]       value    equal    ${dogWalker}[addressCityUf] 

    Click        css=img[alt="Cuidar"]
    Click        css=img[alt="Adestrar"] 

    Upload File By Selector    css=input[type="file"]    ${EXECDIR}/${dogWalker}[rgRobertaPardo]

Submit signup form
    Click        css=.button-register

Popup should be
    [Arguments]    ${dogWalker}
    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text                   css=.swal2-html-container    equal      Recebemos o seu cadastro e em breve retornaremos o contato.
             
    Sleep    10s
   
