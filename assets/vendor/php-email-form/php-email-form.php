<?php
class PHP_Email_Form {
  public $to = '';
  public $from_name = '';
  public $from_email = '';
  public $subject = '';
  public $smtp = [];
  public $ajax = false;

  private $messages = [];

  /**
   * Agrega un mensaje al contenido del correo.
   */
  public function add_message($content, $label, $priority = 0) {
    $this->messages[] = [
      'content' => $content,
      'label' => $label,
      'priority' => $priority
    ];
  }

  /**
   * Envía el correo electrónico.
   */
  public function send() {
    if (empty($this->to) || empty($this->from_email) || empty($this->subject)) {
      return 'Required fields are missing!';
    }

    $email_content = "You have a new message:\n\n";

    // Ordena los mensajes por prioridad
    usort($this->messages, function ($a, $b) {
      return $b['priority'] - $a['priority'];
    });

    foreach ($this->messages as $message) {
      $email_content .= $message['label'] . ": " . $message['content'] . "\n";
    }

    // Configuración para envío con mail()
    $headers = "From: " . $this->from_name . " <" . $this->from_email . ">\r\n";
    $headers .= "Reply-To: " . $this->from_email . "\r\n";

    if (!empty($this->smtp)) {
      return $this->send_smtp($email_content);
    }

    // Usar mail() si no se configura SMTP
    if (mail($this->to, $this->subject, $email_content, $headers)) {
      return 'OK';
    } else {
      return 'Error sending email!';
    }
  }

  /**
   * Envía el correo electrónico usando SMTP.
   */
  private function send_smtp($email_content) {
    // Verifica que las credenciales de SMTP estén configuradas
    if (empty($this->smtp['host']) || empty($this->smtp['username']) || empty($this->smtp['password']) || empty($this->smtp['port'])) {
      return 'SMTP settings are missing!';
    }

    // Cargar PHPMailer o implementar conexión SMTP aquí
    return 'SMTP functionality not implemented yet. Use mail() instead for now.';
  }
}
?>
