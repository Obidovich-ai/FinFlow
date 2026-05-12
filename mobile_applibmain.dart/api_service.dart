// Login tugmasi ichida:
onPressed: () async {
  final result = await AuthService().login(emailController.text, passwordController.text);
  
  if (result['success']) {
    // Muvaffaqiyatli kirsa, Dashboardga o'tamiz
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => DashboardScreen())
    );
  } else {
    // Xato bo'lsa, xabar chiqaramiz
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
    );
  }
}
