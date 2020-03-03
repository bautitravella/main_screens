
enum ChatRole {
  VENDEDOR,
  COMPRADOR,
}



ChatRole chatRolefromString(String roleDescription){
  if(roleDescription == "Vendedor"){
    return ChatRole.VENDEDOR;
  }else{
    return ChatRole.COMPRADOR;
  }
}
