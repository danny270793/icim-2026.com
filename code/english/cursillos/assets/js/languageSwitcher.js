// Objeto con las traducciones
const translations = {
    "navHome": {
      "en": "Home",
      "es": "Inicio"
    },
    "navImportantDates": {
      "en": "Important Dates",
      "es": "Fechas Importantes"
    },
    "navFirstCall": {
      "en": "First Call",
      "es": "Primer Llamado"
    },
    "navGuests": {
      "en": "Guests",
      "es": "Invitados"
    },
    "navPlenaries": {
      "en": "Plenaries",
      "es": "Plenarias"
    },
    "navWorkshops": {
      "en": "Workshops",
      "es": "Cursillos"
    },
    "navProgram": {
      "en": "Program",
      "es": "Programa"
    },
    "navSchedule": {
      "en": "Schedule",
      "es": "Cronograma"
    },
    "navSummaries": {
      "en": "Summaries",
      "es": "Resúmenes"
    },
    "navParticipate": {
      "en": "Participate",
      "es": "Participa"
    },
    "navRegister": {
      "en": "Register",
      "es": "Registro"
    },
    "navAgenda": {
      "en": "Agenda",
      "es": "Agenda"
    },
    "navCommittee": {
      "en": "Committee",
      "es": "Comité"
    },
    "navScientificCommittee": {
      "en": "Scientific Committee",
      "es": "Comité Científico"
    },
    "navOrganizingCommittee": {
      "en": "Organizing Committee",
      "es": "Comité Organizador"
    },
    "navGettingHere": {
      "en": "Getting Here",
      "es": "Cómo llegar"
    },
    "navEspoch": {
      "en": "ESPOCH",
      "es": "ESPOCH"
    },
    "navAccommodation": {
      "en": "Accommodation",
      "es": "Alojamiento"
    },
    "navActivities": {
      "en": "Activities",
      "es": "Actividades"
    },
    "conferenceTitle": {
      "en": "VI Ecuadorian Mathematics Conference",
      "es": "VI Jornadas Ecuatorianas de Matemática"
    },
    "aboutTitle": {
        "en": "About",
        "es": "Acerca de"
    },
    "aboutHeading": {
        "en": "About",
        "es": "Acerca de"
      },
    "aboutDescription": {
        "en": "VI Ecuadorian Mathematics Conference",
        "es": "VI Jornadas Ecuatorianas de Matemática"
      },
    "jemDescription1": {
        "en": "The Ecuadorian Mathematics Conference (JEM) is an annual scientific event organized collaboratively by Ecuadorian university institutions, in association with the Ecuadorian Mathematics Society (SEdeM), the Mathematical Modeling Center (Mode-Mat), and Amarun.",
        "es": "Las Jornadas Ecuatorianas de Matemática (JEM) conforman un evento científico anual organizado de manera colaborativa por instituciones universitarias ecuatorianas, en asociación con la Sociedad Ecuatoriana de Matemática (SEdeM), el Centro de Modelización Matemática (Mode-Mat) y Amarun."
      },
    "jemDescription2": {
        "en": "The fundamental purpose of the JEM is to provide conducive environments for dissemination, analysis, reflection, and debate, with the aim of stimulating the advancement of both research and the educational field in higher mathematics in Ecuador. The essence of the JEM lies in its contribution to the consolidation of strategic alliances among researchers, nationally and internationally. The JEM not only constitutes a manifestation of scientific excellence but also a fundamental component to strengthen the academic and scientific community in the field of mathematics, encouraging research and teaching.",
        "es": "El propósito fundamental de las JEM es proporcionar entornos propicios para la difusión, análisis, reflexión y debate, con el objetivo de estimular el avance tanto de la investigación como del ámbito educativo en matemáticas a nivel superior en Ecuador. La esencia de las JEM radica en su contribución a la consolidación de alianzas estratégicas entre investigadores, a nivel nacional e internacional. Las JEM no solo constituyen una manifestación de excelencia científica, sino también un componente fundamental para fortalecer la comunidad académica y científica en el ámbito de la matemática, incentivando la investigación y la enseñanza."
      },
    "jemDescription3": {
        "en": "This year, the VI Ecuadorian Mathematics Conference will be organized by the Mathematics Department of the Faculty of Sciences, at the Escuela Superior Politécnica de Chimborazo in the city of Riobamba and will take place in November.",
        "es": "Este año las VI Jornadas Ecuatorianas de Matemática serán organizadas por la Carrera de Matemática de la Facultad de Ciencias, de la Escuela Superior Politécnica de Chimborazo en la ciudad de Riobamba y se realizarán en noviembre."
      }, 
    "FontTitle": {
        "en": "VI Ecuadorian Mathematics Conference",
        "es": "VI Jornadas Ecuatorianas de Matemática"
      },
      "placeholderName": {
        "en": "Your Name",
        "es": "Su nombre"
      },
      "placeholderEmail": {
        "en": "Your Email",
        "es": "Su email"
      },
      "placeholderSubject": {
        "en": "Subject",
        "es": "Motivo"
      },
      "placeholderMessage": {
        "en": "Message",
        "es": "Mensaje"
      },
    "contactTitle": {
        "en": "Contact",
        "es": "Contacto"
      },
    "contactHeading": {
        "en": "Contact",
        "es": "Contacto"
      },
    "contactEmailTitle": {
        "en": "Email",
        "es": "Correo Electrónico"
      }, 
    "loadingMessage": {
        "en": "Loading...",
        "es": "Cargando..."
      },
    "errorMessage": {
        "en": "An error occurred. Please try again.",
        "es": "Ocurrió un error. Por favor, inténtalo de nuevo."
      },
    "sentMessage": {
        "en": "Your message has been sent. Thank you!",
        "es": "Tu mensaje ha sido enviado. ¡Gracias!"
      },
    "submitButton": {
        "en": "Send Message",
        "es": "Enviar Mensaje"
      },
    
    // Añade aquí más elementos traducibles según sea necesario...
  };
  
  // Función para cambiar el idioma
  function changeLanguage(lang) {
    Object.keys(translations).forEach(function(key) {
      const element = document.getElementById(key);
      if (element) {
        if (element.tagName === "INPUT" || element.tagName === "TEXTAREA") {
          // Si el elemento es un INPUT o TEXTAREA, actualizamos su placeholder.
          element.placeholder = translations[key][lang];
        } else {
          // Para todos los demás elementos, simplemente actualizamos su texto.
          element.textContent = translations[key][lang];
        }
      }
    });
  }
  
  // Función de inicialización
  function initLanguageSwitcher() {
    const changeLanguageBtn = document.getElementById('changeLanguageBtn');
    if (changeLanguageBtn) {
      changeLanguageBtn.addEventListener('click', function() {
        const currentLang = this.getAttribute('data-lang');
        const newLang = currentLang === 'en' ? 'es' : 'en';
        changeLanguage(newLang);
        this.setAttribute('data-lang', newLang); // Actualiza el atributo para reflejar el cambio de idioma
        // Actualiza el texto del botón, opcional
        this.textContent = newLang === 'en' ? 'Cambiar a español' : 'Change to English';
      });
    }
  }
   
  // Asegurarse de que el DOM esté cargado antes de inicializar
  document.addEventListener('DOMContentLoaded', initLanguageSwitcher);
  