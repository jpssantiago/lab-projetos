String treatAuthErrorMessage(String? str) {
  switch (str) {
    case 'user-not-found':
      return 'O email informado não foi encontrado.';
    case 'email-already-in-use':
      return 'O email informado já está em uso.';
    case 'invalid-email':
      return 'O email informado não é válido.';
    case 'wrong-password':
      return 'A senha informada está incorreta.';
    case 'user-null':
    default:
      return 'Ocorreu um erro, tente novamente mais tarde.';
  }
}
