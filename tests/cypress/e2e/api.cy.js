describe('webrpc-gen-elm', () => {
  it('Gets empty', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#getEmptyBtn').click()
    cy.get('#message').contains('CompletedGetEmpty: Ok').should('exist')  
  })

  it('Gets error', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#getErrorBtn').click()
    cy.get('#message').contains('CompletedGetError: Err').should('exist')  
  })  

  it('Gets one', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#getOneBtn').click()
    cy.get('#message').contains('CompletedGetOne: Ok').should('exist')  
  })  

  it('Sends one', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#sendOneBtn').click()
    cy.get('#message').contains('CompletedSendOne: Ok').should('exist')  
  })    

  it('Gets multi', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#getMultiBtn').click()
    cy.get('#message').contains('CompletedGetMulti: Ok').should('exist')  
  })     

  it('Sends multi', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#sendMultiBtn').click()
    cy.get('#message').contains('CompletedSendMulti: Ok').should('exist')  
  }) 

  it('Gets complex', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#getComplexBtn').click()
    cy.get('#message').contains('CompletedGetComplex: Ok').should('exist')  
  })   

  it('Sends complex', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#sendComplexBtn').click()
    cy.get('#message').contains('CompletedSendComplex: Ok').should('exist')  
  })     

  it('Gets schema error', () => {
    cy.visit('http://127.0.0.1:8080/')
    cy.get('#getSchemaErrorBtn').click()
    cy.get('#message').contains('CompletedGetSchemaError: Err').should('exist')  
  })     
})