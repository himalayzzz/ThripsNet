import 'package:flutter/widgets.dart';

import 'app_language.dart';

class AppCopy {
  const AppCopy(this.language);

  final AppLanguage language;

  static AppCopy of(BuildContext context) {
    return AppCopy(AppLanguageScope.languageOf(context));
  }

  String _text(Map<AppLanguage, String> values) {
    return values[language] ?? values[AppLanguage.english]!;
  }

  String get changeLanguageTooltip => _text(const {
    AppLanguage.english: 'Change language',
    AppLanguage.hindi: 'भाषा बदलें',
    AppLanguage.malayalam: 'ഭാഷ മാറ്റുക',
    AppLanguage.kannada: 'ಭಾಷೆ ಬದಲಿಸಿ',
  });

  String get appName => 'THRIPSNET';

  String get aiFarmAssistant => _text(const {
    AppLanguage.english: 'AI FARM ASSISTANT',
    AppLanguage.hindi: 'एआई फार्म असिस्टेंट',
    AppLanguage.malayalam: 'എഐ ഫാം അസിസ്റ്റന്റ്',
    AppLanguage.kannada: 'ಎಐ ಫಾರ್ಮ್ ಸಹಾಯಕ',
  });

  String get splashHeadline => _text(const {
    AppLanguage.english: 'STOP, BREATHE,\nSCAN SMART',
    AppLanguage.hindi: 'रुकें, सोचें,\nस्मार्ट स्कैन करें',
    AppLanguage.malayalam: 'തടഞ്ഞ് നോക്കൂ,\nസ്മാർട്ടായി സ്കാൻ ചെയ്യൂ',
    AppLanguage.kannada: 'ನಿಲ್ಲಿ, ಯೋಚಿಸಿ,\nಸ್ಮಾರ್ಟ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ',
  });

  String get splashSubtitle => _text(const {
    AppLanguage.english:
        'ThripsNet helps you detect disease signs early and act faster with confidence.',
    AppLanguage.hindi:
        'ThripsNet आपको रोग के संकेत जल्दी पहचानने और भरोसे के साथ तेजी से कार्रवाई करने में मदद करता है।',
    AppLanguage.malayalam:
        'ThripsNet രോഗലക്ഷണങ്ങൾ നേരത്തെ കണ്ടെത്താനും ആത്മവിശ്വാസത്തോടെ വേഗത്തിൽ പ്രവർത്തിക്കാനും നിങ്ങളെ സഹായിക്കുന്നു.',
    AppLanguage.kannada:
        'ThripsNet ರೋಗದ ಲಕ್ಷಣಗಳನ್ನು ಬೇಗ ಪತ್ತೆಹಚ್ಚಿ ಆತ್ಮವಿಶ್ವಾಸದಿಂದ ವೇಗವಾಗಿ ಕ್ರಮ ಕೈಗೊಳ್ಳಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.',
  });

  String get splashFeature => _text(const {
    AppLanguage.english:
        'AI-powered disease alerts, multilingual guidance, and faster field decisions.',
    AppLanguage.hindi:
        'एआई आधारित रोग अलर्ट, बहुभाषी मार्गदर्शन और तेज़ खेत-स्तरीय निर्णय।',
    AppLanguage.malayalam:
        'എഐ അധിഷ്ഠിത രോഗ അലർട്ടുകൾ, ബഹുഭാഷ മാർഗ്ഗനിർദ്ദേശം, വേഗത്തിലുള്ള വയൽ തീരുമാനങ്ങൾ.',
    AppLanguage.kannada:
        'ಎಐ ಆಧಾರಿತ ರೋಗ ಎಚ್ಚರಿಕೆಗಳು, ಬಹುಭಾಷಾ ಮಾರ್ಗದರ್ಶನ ಮತ್ತು ವೇಗವಾದ ಹೊಲದ ನಿರ್ಧಾರಗಳು.',
  });

  String get loading => _text(const {
    AppLanguage.english: 'Loading...',
    AppLanguage.hindi: 'लोड हो रहा है...',
    AppLanguage.malayalam: 'ലോഡ് ചെയ്യുന്നു...',
    AppLanguage.kannada: 'ಲೋಡ್ ಆಗುತ್ತಿದೆ...',
  });

  String get startNow => _text(const {
    AppLanguage.english: 'Start Now',
    AppLanguage.hindi: 'अभी शुरू करें',
    AppLanguage.malayalam: 'ഇപ്പോൾ തുടങ്ങുക',
    AppLanguage.kannada: 'ಈಗ ಪ್ರಾರಂಭಿಸಿ',
  });

  String get goodMorning => _text(const {
    AppLanguage.english: 'Good Morning',
    AppLanguage.hindi: 'सुप्रभात',
    AppLanguage.malayalam: 'സുപ്രഭാതം',
    AppLanguage.kannada: 'ಶುಭೋದಯ',
  });

  String get aiFieldGuide => _text(const {
    AppLanguage.english: 'AI FIELD GUIDE',
    AppLanguage.hindi: 'एआई फील्ड गाइड',
    AppLanguage.malayalam: 'എഐ ഫീൽഡ് ഗൈഡ്',
    AppLanguage.kannada: 'ಎಐ ಫೀಲ್ಡ್ ಗೈಡ್',
  });

  String get liveInsights => _text(const {
    AppLanguage.english: 'LIVE INSIGHTS',
    AppLanguage.hindi: 'लाइव इनसाइट्स',
    AppLanguage.malayalam: 'ലൈവ് ഇൻസൈറ്റ്സ്',
    AppLanguage.kannada: 'ಲೈವ್ ಇನ್ಸೈಟ್ಸ್',
  });

  String get welcomeFarmer => _text(const {
    AppLanguage.english: 'Welcome Farmer',
    AppLanguage.hindi: 'स्वागत है किसान',
    AppLanguage.malayalam: 'സ്വാഗതം കർഷകാ',
    AppLanguage.kannada: 'ಸ್ವಾಗತ ರೈತನೇ',
  });

  String get healthyCropsToday => _text(const {
    AppLanguage.english: 'Let us focus on healthy crops today.',
    AppLanguage.hindi: 'आइए आज स्वस्थ फसलों पर ध्यान दें।',
    AppLanguage.malayalam: 'ഇന്ന് ആരോഗ്യകരമായ വിളകളിൽ ശ്രദ്ധ കേന്ദ്രീകരിക്കാം.',
    AppLanguage.kannada: 'ಇಂದು ಆರೋಗ್ಯಕರ ಬೆಳೆಗಳತ್ತ ಗಮನ ಹರಿಸೋಣ.',
  });

  String locationWithValue(String location) {
    return _text({
      AppLanguage.english: 'Location: $location',
      AppLanguage.hindi: 'स्थान: $location',
      AppLanguage.malayalam: 'സ്ഥലം: $location',
      AppLanguage.kannada: 'ಸ್ಥಳ: $location',
    });
  }

  String get climateSnapshot => _text(const {
    AppLanguage.english: 'Humidity 71% | Temp 29 C',
    AppLanguage.hindi: 'आर्द्रता 71% | तापमान 29 C',
    AppLanguage.malayalam: 'ആർദ്രത 71% | താപനില 29 C',
    AppLanguage.kannada: 'ಆರ್ದ್ರತೆ 71% | ತಾಪಮಾನ 29 C',
  });

  String get quickActions => _text(const {
    AppLanguage.english: 'Quick Actions',
    AppLanguage.hindi: 'त्वरित कार्य',
    AppLanguage.malayalam: 'വേഗ പ്രവർത്തനങ്ങൾ',
    AppLanguage.kannada: 'ತ್ವರಿತ ಕ್ರಮಗಳು',
  });

  String get chooseWorkflow => _text(const {
    AppLanguage.english:
        'Choose an AI-assisted workflow for detection and prevention.',
    AppLanguage.hindi:
        'रोग पहचान और रोकथाम के लिए एआई-सहायता प्राप्त कार्यप्रवाह चुनें।',
    AppLanguage.malayalam:
        'തിരിച്ചറിയലിനും പ്രതിരോധത്തിനുമായി എഐ സഹായത്തോടെയുള്ള പ്രവാഹം തിരഞ്ഞെടുക്കുക.',
    AppLanguage.kannada:
        'ಪತ್ತೆಹಚ್ಚುವಿಕೆ ಮತ್ತು ತಡೆಗಟ್ಟುವಿಕೆಗೆ ಎಐ ಸಹಾಯಿತ ಕಾರ್ಯಪಥವನ್ನು ಆಯ್ಕೆಮಾಡಿ.',
  });

  String get tapToContinue => _text(const {
    AppLanguage.english: 'Tap to continue',
    AppLanguage.hindi: 'आगे बढ़ने के लिए टैप करें',
    AppLanguage.malayalam: 'തുടരാൻ ടാപ്പ് ചെയ്യുക',
    AppLanguage.kannada: 'ಮುಂದುವರಿಸಲು ಟ್ಯಾಪ್ ಮಾಡಿ',
  });

  String get open => _text(const {
    AppLanguage.english: 'Open',
    AppLanguage.hindi: 'खोलें',
    AppLanguage.malayalam: 'തുറക്കുക',
    AppLanguage.kannada: 'ತೆರೆಯಿರಿ',
  });

  String get scanLeaf => _text(const {
    AppLanguage.english: 'Scan Leaf',
    AppLanguage.hindi: 'पत्ती स्कैन करें',
    AppLanguage.malayalam: 'ഇല സ്കാൻ ചെയ്യുക',
    AppLanguage.kannada: 'ಎಲೆ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ',
  });

  String get scanLeafSubtitle => _text(const {
    AppLanguage.english: 'Capture leaf image and run AI detection.',
    AppLanguage.hindi: 'पत्ती की छवि लें और एआई पहचान चलाएं।',
    AppLanguage.malayalam: 'ഇലയുടെ ചിത്രം എടുത്ത് എഐ തിരിച്ചറിയൽ നടത്തുക.',
    AppLanguage.kannada: 'ಎಲೆಯ ಚಿತ್ರವನ್ನು ತೆಗೆದು ಎಐ ಪತ್ತೆಹಚ್ಚುವಿಕೆಯನ್ನು ನಡೆಸಿ.',
  });

  String get detectionTag => _text(const {
    AppLanguage.english: 'DETECTION',
    AppLanguage.hindi: 'डिटेक्शन',
    AppLanguage.malayalam: 'ഡിറ്റെക്ഷൻ',
    AppLanguage.kannada: 'ಪತ್ತೆ',
  });

  String get scanSeed => _text(const {
    AppLanguage.english: 'Scan Seed',
    AppLanguage.hindi: 'बीज स्कैन करें',
    AppLanguage.malayalam: 'വിത്ത് സ്കാൻ ചെയ്യുക',
    AppLanguage.kannada: 'ಬೀಜ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ',
  });

  String get scanSeedSubtitle => _text(const {
    AppLanguage.english: 'Capture seed image and check health indicators.',
    AppLanguage.hindi: 'बीज की छवि लें और स्वास्थ्य संकेतक जांचें।',
    AppLanguage.malayalam:
        'വിത്തിന്റെ ചിത്രം എടുത്ത് ആരോഗ്യ സൂചനകൾ പരിശോധിക്കുക.',
    AppLanguage.kannada: 'ಬೀಜದ ಚಿತ್ರ ತೆಗೆದು ಆರೋಗ್ಯ ಸೂಚನೆಗಳನ್ನು ಪರಿಶೀಲಿಸಿ.',
  });

  String get qualityTag => _text(const {
    AppLanguage.english: 'QUALITY',
    AppLanguage.hindi: 'गुणवत्ता',
    AppLanguage.malayalam: 'ഗുണമേന്മ',
    AppLanguage.kannada: 'ಗುಣಮಟ್ಟ',
  });

  String get viewAlerts => _text(const {
    AppLanguage.english: 'View Alerts',
    AppLanguage.hindi: 'अलर्ट देखें',
    AppLanguage.malayalam: 'അലർട്ടുകൾ കാണുക',
    AppLanguage.kannada: 'ಎಚ್ಚರಿಕೆಗಳನ್ನು ನೋಡಿ',
  });

  String get viewAlertsSubtitle => _text(const {
    AppLanguage.english: 'See latest field warnings and updates.',
    AppLanguage.hindi: 'नवीनतम खेत चेतावनियाँ और अपडेट देखें।',
    AppLanguage.malayalam: 'പുതിയ വയൽ മുന്നറിയിപ്പുകളും അപ്ഡേറ്റുകളും കാണുക.',
    AppLanguage.kannada: 'ಇತ್ತೀಚಿನ ಹೊಲ ಎಚ್ಚರಿಕೆಗಳು ಮತ್ತು ನವೀಕರಣಗಳನ್ನು ನೋಡಿ.',
  });

  String get monitorTag => _text(const {
    AppLanguage.english: 'MONITOR',
    AppLanguage.hindi: 'निगरानी',
    AppLanguage.malayalam: 'നിരീക്ഷണം',
    AppLanguage.kannada: 'ನಿರೀಕ್ಷಣೆ',
  });

  String get weatherTag => _text(const {
    AppLanguage.english: 'WEATHER',
    AppLanguage.hindi: 'मौसम',
    AppLanguage.malayalam: 'കാലാവസ്ഥ',
    AppLanguage.kannada: 'ಹವಾಮಾನ',
  });

  String get weatherTitle => _text(const {
    AppLanguage.english: 'Weather',
    AppLanguage.hindi: 'मौसम',
    AppLanguage.malayalam: 'കാലാവസ്ഥ',
    AppLanguage.kannada: 'ಹವಾಮಾನ',
  });

  String get windTapToFetchLive => _text(const {
    AppLanguage.english: 'Wind: tap to fetch live',
    AppLanguage.hindi: 'हवा: लाइव डेटा पाने के लिए टैप करें',
    AppLanguage.malayalam: 'കാറ്റ്: തത്സമയ വിവരങ്ങൾക്ക് ടാപ്പ് ചെയ്യൂ',
    AppLanguage.kannada: 'ಗಾಳಿ: ನೇರ ಮಾಹಿತಿಗೆ ಟ್ಯಾಪ್ ಮಾಡಿ',
  });

  String get showsNext5Spots => _text(const {
    AppLanguage.english: 'Shows next 5 spots',
    AppLanguage.hindi: 'अगले 5 संभावित स्थान दिखाता है',
    AppLanguage.malayalam: 'അടുത്ത 5 സാധ്യതാ സ്ഥാനങ്ങൾ കാണിക്കും',
    AppLanguage.kannada: 'ಮುಂದಿನ 5 ಸಾಧ್ಯ ಸ್ಥಳಗಳನ್ನು ತೋರಿಸುತ್ತದೆ',
  });

  String get exploreDiseasePrevention => _text(const {
    AppLanguage.english: 'Explore Disease Prevention',
    AppLanguage.hindi: 'रोग रोकथाम देखें',
    AppLanguage.malayalam: 'രോഗ പ്രതിരോധം പരിശോധിക്കുക',
    AppLanguage.kannada: 'ರೋಗ ತಡೆ ಕ್ರಮಗಳನ್ನು ನೋಡಿ',
  });

  String get runDetectionFirstSnack => _text(const {
    AppLanguage.english: 'Run detection first, then open Weather map.',
    AppLanguage.hindi: 'पहले डिटेक्शन चलाएं, फिर मौसम मानचित्र खोलें।',
    AppLanguage.malayalam:
        'ആദ്യം തിരിച്ചറിയൽ നടത്തുക, ശേഷം കാലാവസ്ഥ മാപ്പ് തുറക്കുക.',
    AppLanguage.kannada:
        'ಮೊದಲು ಪತ್ತೆಹಚ್ಚುವಿಕೆ ನಡೆಸಿ, ನಂತರ ಹವಾಮಾನ ನಕ್ಷೆ ತೆರೆಯಿರಿ.',
  });

  String get scanCropLeaf => _text(const {
    AppLanguage.english: 'Scan Crop Leaf',
    AppLanguage.hindi: 'फसल की पत्ती स्कैन करें',
    AppLanguage.malayalam: 'വിളയുടെ ഇല സ്കാൻ ചെയ്യുക',
    AppLanguage.kannada: 'ಬೆಳೆ ಎಲೆ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ',
  });

  String get runAiLeafAnalysis => _text(const {
    AppLanguage.english: 'Run AI leaf analysis in seconds',
    AppLanguage.hindi: 'कुछ सेकंड में एआई पत्ती विश्लेषण चलाएं',
    AppLanguage.malayalam: 'സെക്കൻഡുകൾക്കകം എഐ ഇല വിശകലനം നടത്തുക',
    AppLanguage.kannada: 'ಕೆಲವೇ ಕ್ಷಣಗಳಲ್ಲಿ ಎಐ ಎಲೆ ವಿಶ್ಲೇಷಣೆ ನಡೆಸಿ',
  });

  String get leafAnalysisSubtitle => _text(const {
    AppLanguage.english:
        'Capture or upload a crop leaf to identify visible disease patterns quickly.',
    AppLanguage.hindi:
        'दृश्य रोग संकेतों की तेज पहचान के लिए फसल की पत्ती लें या अपलोड करें।',
    AppLanguage.malayalam:
        'കാണാവുന്ന രോഗ ലക്ഷണങ്ങൾ വേഗത്തിൽ കണ്ടെത്താൻ ഒരു വിളയുടെ ഇല പകർത്തുകയോ അപ്ലോഡ് ചെയ്യുകയോ ചെയ്യുക.',
    AppLanguage.kannada:
        'ಕಾಣಿಸಬಹುದಾದ ರೋಗ ಲಕ್ಷಣಗಳನ್ನು ತ್ವರಿತವಾಗಿ ಗುರುತಿಸಲು ಬೆಳೆ ಎಲೆಯನ್ನು ಸೆರೆಹಿಡಿಯಿರಿ ಅಥವಾ ಅಪ್‌ಲೋಡ್ ಮಾಡಿ.',
  });

  String get chooseInputSource => _text(const {
    AppLanguage.english: 'Choose Input Source',
    AppLanguage.hindi: 'इनपुट स्रोत चुनें',
    AppLanguage.malayalam: 'ഇൻപുട്ട് ഉറവിടം തിരഞ്ഞെടുക്കുക',
    AppLanguage.kannada: 'ಇನ್‌ಪುಟ್ ಮೂಲವನ್ನು ಆಯ್ಕೆಮಾಡಿ',
  });

  String get provideImageForAnalysis => _text(const {
    AppLanguage.english:
        'Select how you want to provide the image for analysis.',
    AppLanguage.hindi: 'विश्लेषण के लिए छवि कैसे देना चाहते हैं, यह चुनें।',
    AppLanguage.malayalam:
        'വിശകലനത്തിനായി ചിത്രം എങ്ങനെ നൽകണമെന്ന് തിരഞ്ഞെടുക്കുക.',
    AppLanguage.kannada: 'ವಿಶ್ಲೇಷಣೆಗೆ ಚಿತ್ರವನ್ನು ಹೇಗೆ ನೀಡಬೇಕು ಎಂದು ಆಯ್ಕೆಮಾಡಿ.',
  });

  String get captureImage => _text(const {
    AppLanguage.english: 'Capture Image',
    AppLanguage.hindi: 'छवि लें',
    AppLanguage.malayalam: 'ചിത്രം പകർത്തുക',
    AppLanguage.kannada: 'ಚಿತ್ರ ಸೆರೆಹಿಡಿಯಿರಿ',
  });

  String get captureImageSubtitle => _text(const {
    AppLanguage.english:
        'Use the camera for a fresh scan directly from the field.',
    AppLanguage.hindi: 'खेत से सीधे नया स्कैन करने के लिए कैमरे का उपयोग करें।',
    AppLanguage.malayalam:
        'വയലിൽ നിന്ന് നേരിട്ട് പുതിയ സ്കാൻക്കായി ക്യാമറ ഉപയോഗിക്കുക.',
    AppLanguage.kannada: 'ಹೊಲದಿಂದಲೇ ಹೊಸ ಸ್ಕ್ಯಾನ್‌ಗೆ ಕ್ಯಾಮೆರಾವನ್ನು ಬಳಸಿ.',
  });

  String get uploadImage => _text(const {
    AppLanguage.english: 'Upload Image',
    AppLanguage.hindi: 'छवि अपलोड करें',
    AppLanguage.malayalam: 'ചിത്രം അപ്ലോഡ് ചെയ്യുക',
    AppLanguage.kannada: 'ಚಿತ್ರ ಅಪ್‌ಲೋಡ್ ಮಾಡಿ',
  });

  String get uploadImageSubtitle => _text(const {
    AppLanguage.english:
        'Choose an existing image and let the model inspect it.',
    AppLanguage.hindi: 'मौजूदा छवि चुनें और मॉडल को जांचने दें।',
    AppLanguage.malayalam:
        'നിലവിലുള്ള ചിത്രം തിരഞ്ഞെടുക്കുക, മോഡൽ അത് പരിശോധിക്കട്ടെ.',
    AppLanguage.kannada:
        'ಇರುವ ಚಿತ್ರವನ್ನು ಆಯ್ಕೆಮಾಡಿ, ಮಾದರಿಯು ಅದನ್ನು ಪರಿಶೀಲಿಸಲಿ.',
  });

  String capturedImageSelected(String fileName) {
    return _text({
      AppLanguage.english: 'Captured image selected: $fileName',
      AppLanguage.hindi: 'कैप्चर की गई छवि चुनी गई: $fileName',
      AppLanguage.malayalam: 'പകർത്തിയ ചിത്രം തിരഞ്ഞെടുത്തു: $fileName',
      AppLanguage.kannada: 'ಸೆರೆಹಿಡಿದ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಲಾಗಿದೆ: $fileName',
    });
  }

  String uploadedImageSelected(String fileName) {
    return _text({
      AppLanguage.english: 'Uploaded image selected: $fileName',
      AppLanguage.hindi: 'अपलोड की गई छवि चुनी गई: $fileName',
      AppLanguage.malayalam: 'അപ്ലോഡ് ചെയ്ത ചിത്രം തിരഞ്ഞെടുത്തു: $fileName',
      AppLanguage.kannada: 'ಅಪ್‌ಲೋಡ್ ಮಾಡಿದ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಲಾಗಿದೆ: $fileName',
    });
  }

  String get imagePickerPermissionError => _text(const {
    AppLanguage.english:
        'Could not open camera/gallery. Please allow app permissions in settings.',
    AppLanguage.hindi:
        'कैमरा या गैलरी नहीं खुली। कृपया सेटिंग्स में ऐप अनुमतियाँ दें।',
    AppLanguage.malayalam:
        'ക്യാമറയോ ഗാലറിയോ തുറക്കാനായില്ല. ക്രമീകരണങ്ങളിൽ ആപ്പ് അനുമതി അനുവദിക്കുക.',
    AppLanguage.kannada:
        'ಕ್ಯಾಮೆರಾ ಅಥವಾ ಗ್ಯಾಲರಿ ತೆರೆಯಲಾಗಲಿಲ್ಲ. ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ಅಪ್ಲಿಕೇಶನ್ ಅನುಮತಿಗಳನ್ನು ನೀಡಿ.',
  });

  String get processing => _text(const {
    AppLanguage.english: 'Processing',
    AppLanguage.hindi: 'प्रोसेस हो रहा है',
    AppLanguage.malayalam: 'പ്രോസസ്സ് ചെയ്യുന്നു',
    AppLanguage.kannada: 'ಪ್ರಕ್ರಿಯೆ ನಡೆಯುತ್ತಿದೆ',
  });

  String get analyzingLeafImage => _text(const {
    AppLanguage.english: 'Analyzing leaf image...',
    AppLanguage.hindi: 'पत्ती की छवि का विश्लेषण हो रहा है...',
    AppLanguage.malayalam: 'ഇലയുടെ ചിത്രം വിശകലനം ചെയ്യുന്നു...',
    AppLanguage.kannada: 'ಎಲೆಯ ಚಿತ್ರವನ್ನು ವಿಶ್ಲೇಷಿಸಲಾಗುತ್ತಿದೆ...',
  });

  String get runningAiModel => _text(const {
    AppLanguage.english: 'Running AI model...',
    AppLanguage.hindi: 'एआई मॉडल चल रहा है...',
    AppLanguage.malayalam: 'എഐ മോഡൽ പ്രവർത്തിക്കുന്നു...',
    AppLanguage.kannada: 'ಎಐ ಮಾದರಿ ಕಾರ್ಯನಿರ್ವಹಿಸುತ್ತಿದೆ...',
  });

  String get noImageSelected => _text(const {
    AppLanguage.english: 'No image selected',
    AppLanguage.hindi: 'कोई छवि चयनित नहीं है',
    AppLanguage.malayalam: 'ചിത്രം തിരഞ്ഞെടുക്കപ്പെട്ടിട്ടില്ല',
    AppLanguage.kannada: 'ಯಾವುದೇ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಲಾಗಿಲ್ಲ',
  });

  String get detectDisease => _text(const {
    AppLanguage.english: 'Detect Disease',
    AppLanguage.hindi: 'रोग पहचानें',
    AppLanguage.malayalam: 'രോഗം തിരിച്ചറിയുക',
    AppLanguage.kannada: 'ರೋಗ ಪತ್ತೆಹಚ್ಚಿ',
  });

  String modelEvaluationFailed(String error) {
    return _text({
      AppLanguage.english: 'Model evaluation failed: $error',
      AppLanguage.hindi: 'मॉडल मूल्यांकन विफल हुआ: $error',
      AppLanguage.malayalam: 'മോഡൽ മൂല്യനിർണ്ണയം പരാജയപ്പെട്ടു: $error',
      AppLanguage.kannada: 'ಮಾದರಿ ಮೌಲ್ಯಮಾಪನ ವಿಫಲವಾಯಿತು: $error',
    });
  }

  String get scanSeedQualityWithAi => _text(const {
    AppLanguage.english: 'Scan seed quality with AI support',
    AppLanguage.hindi: 'एआई सहायता से बीज गुणवत्ता स्कैन करें',
    AppLanguage.malayalam: 'എഐ സഹായത്തോടെ വിത്തിന്റെ ഗുണമേന്മ സ്കാൻ ചെയ്യുക',
    AppLanguage.kannada: 'ಎಐ ಸಹಾಯದಿಂದ ಬೀಜದ ಗುಣಮಟ್ಟ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ',
  });

  String get seedQualitySubtitle => _text(const {
    AppLanguage.english:
        'Check seed condition using a captured or uploaded image before planting.',
    AppLanguage.hindi:
        'रोपाई से पहले कैप्चर या अपलोड की गई छवि से बीज की स्थिति जांचें।',
    AppLanguage.malayalam:
        'നട്ടുപിടിപ്പിക്കുന്നതിന് മുമ്പ് പകർത്തിയതോ അപ്ലോഡ് ചെയ്തതോ ആയ ചിത്രം ഉപയോഗിച്ച് വിത്തിന്റെ നില പരിശോധിക്കുക.',
    AppLanguage.kannada:
        'ನೆಡುವ ಮೊದಲು ಸೆರೆಹಿಡಿದ ಅಥವಾ ಅಪ್‌ಲೋಡ್ ಮಾಡಿದ ಚಿತ್ರದ ಮೂಲಕ ಬೀಜದ ಸ್ಥಿತಿಯನ್ನು ಪರಿಶೀಲಿಸಿ.',
  });

  String get provideSeedImage => _text(const {
    AppLanguage.english:
        'Provide an image and let the model inspect seed quality cues.',
    AppLanguage.hindi: 'एक छवि दें और मॉडल को बीज गुणवत्ता संकेत जांचने दें।',
    AppLanguage.malayalam:
        'ഒരു ചിത്രം നൽകുക; വിത്തിന്റെ ഗുണമേന്മാ സൂചനകൾ മോഡൽ പരിശോധിക്കട്ടെ.',
    AppLanguage.kannada:
        'ಒಂದು ಚಿತ್ರವನ್ನು ನೀಡಿ; ಬೀಜದ ಗುಣಮಟ್ಟದ ಸೂಚನೆಗಳನ್ನು ಮಾದರಿ ಪರಿಶೀಲಿಸಲಿ.',
  });

  String get captureSeedImage => _text(const {
    AppLanguage.english: 'Capture Seed Image',
    AppLanguage.hindi: 'बीज की छवि लें',
    AppLanguage.malayalam: 'വിത്തിന്റെ ചിത്രം പകർത്തുക',
    AppLanguage.kannada: 'ಬೀಜದ ಚಿತ್ರ ಸೆರೆಹಿಡಿಯಿರಿ',
  });

  String get captureSeedImageSubtitle => _text(const {
    AppLanguage.english: 'Open the camera and scan the seed sample instantly.',
    AppLanguage.hindi: 'कैमरा खोलें और बीज नमूना तुरंत स्कैन करें।',
    AppLanguage.malayalam: 'ക്യാമറ തുറന്ന് വിത്ത് സാമ്പിൾ ഉടൻ സ്കാൻ ചെയ്യുക.',
    AppLanguage.kannada:
        'ಕ್ಯಾಮೆರಾ ತೆರೆಯಿರಿ ಮತ್ತು ಬೀಜ ಮಾದರಿಯನ್ನು ತಕ್ಷಣ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ.',
  });

  String get uploadSeedImage => _text(const {
    AppLanguage.english: 'Upload Seed Image',
    AppLanguage.hindi: 'बीज छवि अपलोड करें',
    AppLanguage.malayalam: 'വിത്ത് ചിത്രം അപ്ലോഡ് ചെയ്യുക',
    AppLanguage.kannada: 'ಬೀಜ ಚಿತ್ರ ಅಪ್‌ಲೋಡ್ ಮಾಡಿ',
  });

  String get uploadSeedImageSubtitle => _text(const {
    AppLanguage.english:
        'Use an existing photo for quick AI-assisted evaluation.',
    AppLanguage.hindi:
        'तेज़ एआई-सहायता मूल्यांकन के लिए मौजूदा फोटो का उपयोग करें।',
    AppLanguage.malayalam:
        'വേഗത്തിലുള്ള എഐ സഹായിത വിലയിരുത്തലിന് നിലവിലുള്ള ചിത്രം ഉപയോഗിക്കുക.',
    AppLanguage.kannada: 'ವೇಗವಾದ ಎಐ ಸಹಾಯಿತ ಮೌಲ್ಯಮಾಪನಕ್ಕಾಗಿ ಇರುವ ಫೋಟೋ ಬಳಸಿ.',
  });

  String capturedSeedImageSelected(String fileName) {
    return _text({
      AppLanguage.english: 'Captured seed image selected: $fileName',
      AppLanguage.hindi: 'कैप्चर की गई बीज छवि चुनी गई: $fileName',
      AppLanguage.malayalam: 'പകർത്തിയ വിത്ത് ചിത്രം തിരഞ്ഞെടുത്തു: $fileName',
      AppLanguage.kannada: 'ಸೆರೆಹಿಡಿದ ಬೀಜದ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಲಾಗಿದೆ: $fileName',
    });
  }

  String uploadedSeedImageSelected(String fileName) {
    return _text({
      AppLanguage.english: 'Uploaded seed image selected: $fileName',
      AppLanguage.hindi: 'अपलोड की गई बीज छवि चुनी गई: $fileName',
      AppLanguage.malayalam:
          'അപ്ലോഡ് ചെയ്ത വിത്ത് ചിത്രം തിരഞ്ഞെടുത്തു: $fileName',
      AppLanguage.kannada:
          'ಅಪ್‌ಲೋಡ್ ಮಾಡಿದ ಬೀಜದ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಲಾಗಿದೆ: $fileName',
    });
  }

  String get analyzingSeedImage => _text(const {
    AppLanguage.english: 'Analyzing seed image...',
    AppLanguage.hindi: 'बीज छवि का विश्लेषण हो रहा है...',
    AppLanguage.malayalam: 'വിത്ത് ചിത്രം വിശകലനം ചെയ്യുന്നു...',
    AppLanguage.kannada: 'ಬೀಜದ ಚಿತ್ರವನ್ನು ವಿಶ್ಲೇಷಿಸಲಾಗುತ್ತಿದೆ...',
  });

  String get noSeedImageSelected => _text(const {
    AppLanguage.english: 'No seed image selected',
    AppLanguage.hindi: 'कोई बीज छवि चयनित नहीं है',
    AppLanguage.malayalam: 'വിത്ത് ചിത്രം തിരഞ്ഞെടുക്കപ്പെട്ടിട്ടില്ല',
    AppLanguage.kannada: 'ಯಾವುದೇ ಬೀಜದ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಲಾಗಿಲ್ಲ',
  });

  String get detectSeedCondition => _text(const {
    AppLanguage.english: 'Detect Seed Condition',
    AppLanguage.hindi: 'बीज की स्थिति पहचानें',
    AppLanguage.malayalam: 'വിത്തിന്റെ നില തിരിച്ചറിയുക',
    AppLanguage.kannada: 'ಬೀಜದ ಸ್ಥಿತಿ ಪತ್ತೆಹಚ್ಚಿ',
  });

  String get seedModelNotConfigured => _text(const {
    AppLanguage.english: 'Seed quality model not configured',
    AppLanguage.hindi: 'बीज गुणवत्ता मॉडल कॉन्फ़िगर नहीं है',
    AppLanguage.malayalam: 'വിത്ത് ഗുണമേന്മ മോഡൽ ക്രമീകരിച്ചിട്ടില്ല',
    AppLanguage.kannada: 'ಬೀಜ ಗುಣಮಟ್ಟದ ಮಾದರಿ ಸಂರಚನೆಯಾಗಿಲ್ಲ',
  });

  String get noSeedClassifierConfigured => _text(const {
    AppLanguage.english: 'No seed classifier configured for this flow yet.',
    AppLanguage.hindi:
        'इस प्रक्रिया के लिए अभी बीज क्लासिफायर कॉन्फ़िगर नहीं किया गया है।',
    AppLanguage.malayalam:
        'ഈ പ്രവാഹത്തിനായി ഇനിയും വിത്ത് ക്ലാസിഫയർ ക്രമീകരിച്ചിട്ടില്ല.',
    AppLanguage.kannada:
        'ಈ ಪ್ರಕ್ರಿಯೆಗೆ ಇನ್ನೂ ಬೀಜ ವರ್ಗೀಕರಣ ಮಾದರಿ ಸಂರಚನೆಯಾಗಿಲ್ಲ.',
  });

  String get connectDedicatedSeedModel => _text(const {
    AppLanguage.english:
        'Connect a dedicated seed model for accurate seed condition predictions.',
    AppLanguage.hindi:
        'सटीक बीज स्थिति पूर्वानुमान के लिए अलग बीज मॉडल जोड़ें।',
    AppLanguage.malayalam:
        'കൃത്യമായ വിത്ത് നില പ്രവചനങ്ങൾക്ക് പ്രത്യേക വിത്ത് മോഡൽ ബന്ധിപ്പിക്കുക.',
    AppLanguage.kannada:
        'ನಿಖರವಾದ ಬೀಜ ಸ್ಥಿತಿ ಊಹೆಗಳಿಗಾಗಿ ವಿಶೇಷ ಬೀಜ ಮಾದರಿಯನ್ನು ಜೋಡಿಸಿ.',
  });

  String get detectionResult => _text(const {
    AppLanguage.english: 'Detection Result',
    AppLanguage.hindi: 'पहचान परिणाम',
    AppLanguage.malayalam: 'തിരിച്ചറിയൽ ഫലം',
    AppLanguage.kannada: 'ಪತ್ತೆ ಫಲಿತಾಂಶ',
  });

  String get aiDetectionComplete => _text(const {
    AppLanguage.english: 'AI Detection Complete',
    AppLanguage.hindi: 'एआई पहचान पूर्ण',
    AppLanguage.malayalam: 'എഐ തിരിച്ചറിയൽ പൂർത്തിയായി',
    AppLanguage.kannada: 'ಎಐ ಪತ್ತೆ ಪೂರ್ಣಗೊಂಡಿದೆ',
  });

  String get detectionCompleteSubtitle => _text(const {
    AppLanguage.english:
        'The model has identified likely infection markers and generated spread-risk context.',
    AppLanguage.hindi:
        'मॉडल ने संभावित संक्रमण संकेत पहचाने हैं और फैलाव-जोखिम संदर्भ बनाया है।',
    AppLanguage.malayalam:
        'മോഡൽ സാധ്യതയുള്ള രോഗ ലക്ഷണങ്ങൾ കണ്ടെത്തി വ്യാപന അപകടസാധ്യതയും നിർണയിച്ചു.',
    AppLanguage.kannada:
        'ಮಾದರಿಯು ಸಾಧ್ಯವಾದ ಸೋಂಕಿನ ಲಕ್ಷಣಗಳನ್ನು ಗುರುತಿಸಿ ಹರಡುವ ಅಪಾಯದ ಸಂದರ್ಭವನ್ನು ನಿರ್ಮಿಸಿದೆ.',
  });

  String get modelPrediction => _text(const {
    AppLanguage.english: 'Model Prediction',
    AppLanguage.hindi: 'मॉडल पूर्वानुमान',
    AppLanguage.malayalam: 'മോഡൽ പ്രവചനം',
    AppLanguage.kannada: 'ಮಾದರಿ ಊಹೆ',
  });

  String confidenceWithValue(String value) {
    return _text({
      AppLanguage.english: 'Confidence: $value',
      AppLanguage.hindi: 'विश्वास स्तर: $value',
      AppLanguage.malayalam: 'വിശ്വാസം: $value',
      AppLanguage.kannada: 'ವಿಶ್ವಾಸ ಮಟ್ಟ: $value',
    });
  }

  String get detectedSymptoms => _text(const {
    AppLanguage.english: 'Detected Symptoms',
    AppLanguage.hindi: 'पहचाने गए लक्षण',
    AppLanguage.malayalam: 'കണ്ടെത്തിയ ലക്ഷണങ്ങൾ',
    AppLanguage.kannada: 'ಪತ್ತೆಯಾದ ಲಕ್ಷಣಗಳು',
  });

  String get riskLevel => _text(const {
    AppLanguage.english: 'Risk Level',
    AppLanguage.hindi: 'जोखिम स्तर',
    AppLanguage.malayalam: 'അപകടനില',
    AppLanguage.kannada: 'ಅಪಾಯ ಮಟ್ಟ',
  });

  String recommendationWithValue(String text) {
    return _text({
      AppLanguage.english: 'Recommendation: $text',
      AppLanguage.hindi: 'सिफारिश: $text',
      AppLanguage.malayalam: 'ശുപാർശ: $text',
      AppLanguage.kannada: 'ಶಿಫಾರಸು: $text',
    });
  }

  String get noThripsDetectionFoundYet => _text(const {
    AppLanguage.english: 'No thrips detection found yet.',
    AppLanguage.hindi: 'अभी तक थ्रिप्स पहचान नहीं मिली।',
    AppLanguage.malayalam: 'ഇനിയും ത്രിപ്സ് തിരിച്ചറിവ് ലഭിച്ചിട്ടില്ല.',
    AppLanguage.kannada: 'ಇನ್ನೂ ಥ್ರಿಪ್ಸ್ ಪತ್ತೆಯಾಗಿಲ್ಲ.',
  });

  String get weatherSpreadMap => _text(const {
    AppLanguage.english: 'Weather Spread Map',
    AppLanguage.hindi: 'मौसम फैलाव मानचित्र',
    AppLanguage.malayalam: 'കാലാവസ്ഥ വ്യാപന മാപ്പ്',
    AppLanguage.kannada: 'ಹವಾಮಾನ ಹರಡುವಿಕೆ ನಕ್ಷೆ',
  });

  String get noDiseaseFound => _text(const {
    AppLanguage.english: 'No Disease Found',
    AppLanguage.hindi: 'कोई रोग नहीं मिला',
    AppLanguage.malayalam: 'രോഗം കണ്ടെത്തിയില്ല',
    AppLanguage.kannada: 'ಯಾವುದೇ ರೋಗ ಕಂಡುಬಂದಿಲ್ಲ',
  });

  String translateDiseaseLabel(String rawLabel) {
    final String normalized = rawLabel.toLowerCase().trim();

    if (normalized.contains('breach detected')) {
      return _text(const {
        AppLanguage.english: 'TSWV Breach Detected',
        AppLanguage.hindi: 'TSWV संक्रमण फैलाव अलर्ट',
        AppLanguage.malayalam: 'TSWV വ്യാപന മുന്നറിയിപ്പ്',
        AppLanguage.kannada: 'TSWV ಹರಡುವಿಕೆ ಎಚ್ಚರಿಕೆ',
      });
    }

    if (normalized.contains('healthy') ||
        normalized.contains('no disease detected')) {
      return noDiseaseFound;
    }

    if (normalized.contains('bacterial spot')) {
      return _text(const {
        AppLanguage.english: 'Tomato Bacterial Spot',
        AppLanguage.hindi: 'टमाटर बैक्टीरियल स्पॉट',
        AppLanguage.malayalam: 'തക്കാളി ബാക്ടീരിയൽ സ്പോട്ട്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಬ್ಯಾಕ್ಟೀರಿಯಲ್ ಸ್ಪಾಟ್',
      });
    }

    if (normalized.contains('early blight')) {
      return _text(const {
        AppLanguage.english: 'Tomato Early Blight',
        AppLanguage.hindi: 'टमाटर अर्ली ब्लाइट',
        AppLanguage.malayalam: 'തക്കാളി എർലി ബ്ലൈറ്റ്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಅರ್‌ಲಿ ಬ್ಲೈಟ್',
      });
    }

    if (normalized.contains('late blight')) {
      return _text(const {
        AppLanguage.english: 'Tomato Late Blight',
        AppLanguage.hindi: 'टमाटर लेट ब्लाइट',
        AppLanguage.malayalam: 'തക്കാളി ലേറ്റ് ബ്ലൈറ്റ്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಲೇಟ್ ಬ್ಲೈಟ್',
      });
    }

    if (normalized.contains('leaf mold')) {
      return _text(const {
        AppLanguage.english: 'Tomato Leaf Mold',
        AppLanguage.hindi: 'टमाटर लीफ मोल्ड',
        AppLanguage.malayalam: 'തക്കാളി ലീഫ് മോൾഡ്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಲೀಫ್ ಮೋಲ್ಡ್',
      });
    }

    if (normalized.contains('septoria')) {
      return _text(const {
        AppLanguage.english: 'Tomato Septoria Leaf Spot',
        AppLanguage.hindi: 'टमाटर सेप्टोरिया लीफ स्पॉट',
        AppLanguage.malayalam: 'തക്കാളി സെപ്റ്റോറിയ ലീഫ് സ്പോട്ട്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಸೆಪ್ಟೋರಿಯಾ ಲೀಫ್ ಸ್ಪಾಟ್',
      });
    }

    if (normalized.contains('spider mite')) {
      return _text(const {
        AppLanguage.english: 'Tomato Spider Mites',
        AppLanguage.hindi: 'टमाटर स्पाइडर माइट्स',
        AppLanguage.malayalam: 'തക്കാളി സ്പൈഡർ മൈറ്റ്സ്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಸ್ಪೈಡರ್ ಮೈಟ್ಸ್',
      });
    }

    if (normalized.contains('target spot')) {
      return _text(const {
        AppLanguage.english: 'Tomato Target Spot',
        AppLanguage.hindi: 'टमाटर टारगेट स्पॉट',
        AppLanguage.malayalam: 'തക്കാളി ടാർഗെറ്റ് സ്പോട്ട്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಟಾರ್ಗೆಟ್ ಸ್ಪಾಟ್',
      });
    }

    if (normalized.contains('yellow leaf curl')) {
      return _text(const {
        AppLanguage.english: 'Tomato Yellow Leaf Curl Virus',
        AppLanguage.hindi: 'टमाटर येलो लीफ कर्ल वायरस',
        AppLanguage.malayalam: 'തക്കാളി യെല്ലോ ലീഫ് കർൾ വൈറസ്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಯೆಲ್ಲೋ ಲೀಫ್ ಕರ್‌ಲ್ ವೈರಸ್',
      });
    }

    if (normalized.contains('mosaic virus')) {
      return _text(const {
        AppLanguage.english: 'Tomato Mosaic Virus',
        AppLanguage.hindi: 'टमाटर मोज़ेक वायरस',
        AppLanguage.malayalam: 'തക്കാളി മൊസൈക് വൈറസ്',
        AppLanguage.kannada: 'ಟೊಮೇಟೊ ಮೋಸಾಯಿಕ್ ವೈರಸ್',
      });
    }

    return rawLabel;
  }

  String translateSymptom(String rawSymptom) {
    final String normalized = rawSymptom.toLowerCase().trim();

    if (normalized.contains('no major visible disease symptoms detected')) {
      return _text(const {
        AppLanguage.english: 'No major visible disease symptoms detected.',
        AppLanguage.hindi: 'कोई प्रमुख दृश्य रोग लक्षण नहीं पाए गए।',
        AppLanguage.malayalam: 'പ്രധാനമായ ദൃശ്യ രോഗലക്ഷണങ്ങൾ കണ്ടെത്തിയില്ല.',
        AppLanguage.kannada: 'ಪ್ರಮುಖ ದೃಶ್ಯ ರೋಗ ಲಕ್ಷಣಗಳು ಪತ್ತೆಯಾಗಿಲ್ಲ.',
      });
    }
    if (normalized.contains(
      'leaf texture and color pattern appear consistent',
    )) {
      return _text(const {
        AppLanguage.english:
            'Leaf texture and color pattern appear consistent with healthy foliage.',
        AppLanguage.hindi:
            'पत्ती की बनावट और रंग पैटर्न स्वस्थ पत्तियों जैसा है।',
        AppLanguage.malayalam:
            'ഇലയുടെ ഘടനയും നിറരീതിയും ആരോഗ്യകരമായ ഇലകളോട് സാമ്യമുണ്ട്.',
        AppLanguage.kannada:
            'ಎಲೆಯ ರಚನೆ ಮತ್ತು ಬಣ್ಣ ಮಾದರಿ ಆರೋಗ್ಯಕರ ಎಲೆಗಳಿಗೆ ಹೊಂದಿಕೆಯಾಗುತ್ತದೆ.',
      });
    }
    if (normalized.contains('small dark water-soaked spots on leaves')) {
      return _text(const {
        AppLanguage.english: 'Small dark water-soaked spots on leaves.',
        AppLanguage.hindi: 'पत्तियों पर छोटे गहरे पानी-जैसे धब्बे।',
        AppLanguage.malayalam: 'ഇലകളിൽ ചെറുതും ഇരുണ്ടതുമായ ജലപൂരിത പാടുകൾ.',
        AppLanguage.kannada: 'ಎಲೆಗಳ ಮೇಲೆ ಸಣ್ಣ ಗಾಢ ನೀರು ತುಂಬಿದ ಕಲೆಗಳು.',
      });
    }
    if (normalized.contains('yellow halo')) {
      return _text(const {
        AppLanguage.english: 'Spots may turn brown-black with yellow halo.',
        AppLanguage.hindi: 'धब्बे पीले घेरे के साथ भूरा-काला हो सकते हैं।',
        AppLanguage.malayalam: 'പാടുകൾ മഞ്ഞ വലയത്തോടെ തവിട്ടു-കറുപ്പാകാം.',
        AppLanguage.kannada: 'ಕಲೆಗಳು ಹಳದಿ ವಲಯದೊಂದಿಗೆ ಕಂದು-ಕಪ್ಪಾಗಬಹುದು.',
      });
    }
    if (normalized.contains('brown concentric ring lesions')) {
      return _text(const {
        AppLanguage.english:
            'Brown concentric ring lesions (target-like spots).',
        AppLanguage.hindi: 'भूरे समकेंद्रीय घाव (टारगेट जैसे धब्बे)।',
        AppLanguage.malayalam:
            'തവിട്ടു നിറത്തിലുള്ള വൃത്താകൃതിയിലുള്ള വളയ പാടുകൾ.',
        AppLanguage.kannada:
            'ಕಂದು ಬಣ್ಣದ ವಲಯಾಕಾರ ಗಾಯಗಳು (ಟಾರ್ಗೆಟ್ ಮಾದರಿ ಕಲೆಗಳು).',
      });
    }
    if (normalized.contains('yellowing around lesions')) {
      return _text(const {
        AppLanguage.english: 'Yellowing around lesions on older leaves.',
        AppLanguage.hindi: 'पुरानी पत्तियों में घावों के आसपास पीलापन।',
        AppLanguage.malayalam: 'പഴയ ഇലകളിലെ പാടുകൾക്കു ചുറ്റും മഞ്ഞനിറം.',
        AppLanguage.kannada: 'ಹಳೆಯ ಎಲೆಗಳ ಗಾಯಗಳ ಸುತ್ತ ಹಳದಿಯಾಗುವುದು.',
      });
    }
    if (normalized.contains('irregular dark-green or brown lesions')) {
      return _text(const {
        AppLanguage.english: 'Irregular dark-green or brown lesions.',
        AppLanguage.hindi: 'अनियमित गहरे हरे या भूरे घाव।',
        AppLanguage.malayalam: 'അസമമായ ഇരുണ്ട പച്ച അല്ലെങ്കിൽ തവിട്ട് പാടുകൾ.',
        AppLanguage.kannada: 'ಅಸಮ ಗಾಢ ಹಸಿರು ಅಥವಾ ಕಂದು ಗಾಯಗಳು.',
      });
    }
    if (normalized.contains('rapid spread of leaf blight')) {
      return _text(const {
        AppLanguage.english:
            'Rapid spread of leaf blight under humid conditions.',
        AppLanguage.hindi: 'नमी वाले मौसम में रोग तेजी से फैलता है।',
        AppLanguage.malayalam:
            'ഈർപ്പമുള്ള സാഹചര്യങ്ങളിൽ ഇല രോഗം വേഗത്തിൽ പടരും.',
        AppLanguage.kannada:
            'ತೇವಾಂಶಯುಕ್ತ ಪರಿಸ್ಥಿತಿಯಲ್ಲಿ ಎಲೆರೋಗ ವೇಗವಾಗಿ ಹರಡುತ್ತದೆ.',
      });
    }
    if (normalized.contains('yellow patches on upper leaf surface')) {
      return _text(const {
        AppLanguage.english: 'Yellow patches on upper leaf surface.',
        AppLanguage.hindi: 'पत्तियों के ऊपरी भाग पर पीले धब्बे।',
        AppLanguage.malayalam: 'ഇലയുടെ മുകളിലെ ഭാഗത്ത് മഞ്ഞ പാച്ചുകൾ.',
        AppLanguage.kannada: 'ಎಲೆಯ ಮೇಲ್ಮೈಯಲ್ಲಿ ಹಳದಿ ಚುಕ್ಕೆಗಳು.',
      });
    }
    if (normalized.contains('olive-green to gray mold')) {
      return _text(const {
        AppLanguage.english:
            'Olive-green to gray mold growth underneath leaves.',
        AppLanguage.hindi: 'पत्तियों के नीचे जैतूनी-हरे से धूसर फफूंद।',
        AppLanguage.malayalam: 'ഇലയുടെ അടിഭാഗത്ത് പച്ച-ചാര നിറ പൂപ്പൽ വളർച്ച.',
        AppLanguage.kannada:
            'ಎಲೆಗಳ ಕೆಳಭಾಗದಲ್ಲಿ ಆಲಿವ್-ಹಸಿರುದಿಂದ ಬೂದು ಬಣ್ಣದ ಫಂಗಸ್.',
      });
    }
    if (normalized.contains('numerous small circular spots')) {
      return _text(const {
        AppLanguage.english: 'Numerous small circular spots with dark margins.',
        AppLanguage.hindi: 'गहरे किनारों वाले कई छोटे गोल धब्बे।',
        AppLanguage.malayalam:
            'ഇരുണ്ട അതിരുകളുള്ള നിരവധി ചെറു വൃത്താകൃതിയിലുള്ള പാടുകൾ.',
        AppLanguage.kannada: 'ಕತ್ತಲೆ ಅಂಚುಗಳಿರುವ ಅನೇಕ ಸಣ್ಣ ವೃತ್ತಾಕಾರ ಕಲೆಗಳು.',
      });
    }
    if (normalized.contains('tiny black fruiting dots')) {
      return _text(const {
        AppLanguage.english: 'Tiny black fruiting dots in lesion centers.',
        AppLanguage.hindi: 'घावों के बीच में छोटे काले बिंदु।',
        AppLanguage.malayalam: 'പാടുകളുടെ മദ്ധ്യത്തിൽ ചെറിയ കറുത്ത ബിന്ദുക്കൾ.',
        AppLanguage.kannada: 'ಗಾಯದ ಮಧ್ಯಭಾಗದಲ್ಲಿ ಸಣ್ಣ ಕಪ್ಪು ಕಣಗಳು.',
      });
    }
    if (normalized.contains('speckled yellow stippling')) {
      return _text(const {
        AppLanguage.english: 'Speckled yellow stippling on leaves.',
        AppLanguage.hindi: 'पत्तियों पर छोटे पीले बिंदु जैसी चित्तियाँ।',
        AppLanguage.malayalam: 'ഇലകളിൽ ചിന്നിച്ചിട്ട മഞ്ഞപ്പുള്ളികൾ.',
        AppLanguage.kannada: 'ಎಲೆಗಳ ಮೇಲೆ ಚುಕ್ಕೆಚುಕ್ಕೆಯ ಹಳದಿ ಕಲೆಗಳು.',
      });
    }
    if (normalized.contains('fine webbing')) {
      return _text(const {
        AppLanguage.english: 'Fine webbing around leaf veins or undersides.',
        AppLanguage.hindi: 'पत्ती की नसों या निचले हिस्से में महीन जाला।',
        AppLanguage.malayalam:
            'ഇല നരമ്പുകൾക്കും അടിഭാഗത്തിനും ചുറ്റും ചെറു ജാലം.',
        AppLanguage.kannada: 'ಎಲೆ ನರಗಳು ಅಥವಾ ಕೆಳಭಾಗದ ಸುತ್ತ ನುಣ್ಣಗೆ ಜಾಲ.',
      });
    }
    if (normalized.contains('circular brown lesions')) {
      return _text(const {
        AppLanguage.english: 'Circular brown lesions with concentric rings.',
        AppLanguage.hindi: 'वलयाकार घेरों वाले गोल भूरे घाव।',
        AppLanguage.malayalam: 'വളയങ്ങളുള്ള വൃത്താകൃതിയിലുള്ള തവിട്ട് പാടുകൾ.',
        AppLanguage.kannada: 'ವಲಯಗಳಿರುವ ವೃತ್ತಾಕಾರದ ಕಂದು ಗಾಯಗಳು.',
      });
    }
    if (normalized.contains('lesion expansion and leaf yellowing')) {
      return _text(const {
        AppLanguage.english:
            'Lesion expansion and leaf yellowing around spots.',
        AppLanguage.hindi: 'धब्बों के आसपास घाव फैलना और पीलापन।',
        AppLanguage.malayalam:
            'പാടുകൾക്ക് ചുറ്റും ക്ഷതം പടരുകയും ഇല മഞ്ഞയാകുകയും ചെയ്യുന്നു.',
        AppLanguage.kannada: 'ಕಲೆಗಳ ಸುತ್ತ ಗಾಯ ವಿಸ್ತರಿಸಿ ಎಲೆಗಳು ಹಳದಿಯಾಗುತ್ತವೆ.',
      });
    }
    if (normalized.contains('upward leaf curling')) {
      return _text(const {
        AppLanguage.english: 'Upward leaf curling and yellowing.',
        AppLanguage.hindi: 'पत्तियों का ऊपर की ओर मुड़ना और पीलापन।',
        AppLanguage.malayalam:
            'ഇലകൾ മേലോട്ടു വളയുകയും മഞ്ഞനിറമാകുകയും ചെയ്യുന്നു.',
        AppLanguage.kannada: 'ಎಲೆಗಳು ಮೇಲಕ್ಕೆ ಮಡಿಯುತ್ತಾ ಹಳದಿಯಾಗುತ್ತವೆ.',
      });
    }
    if (normalized.contains('reduced leaf size and stunted')) {
      return _text(const {
        AppLanguage.english: 'Reduced leaf size and stunted plant growth.',
        AppLanguage.hindi: 'पत्तियों का आकार छोटा और पौधे की वृद्धि रुकना।',
        AppLanguage.malayalam:
            'ഇല വലുപ്പം കുറയുകയും ചെടി വളർച്ച തടസപ്പെടുകയും ചെയ്യുന്നു.',
        AppLanguage.kannada:
            'ಎಲೆಯ ಗಾತ್ರ ಕಡಿಮೆಯಾಗಿದ್ದು ಸಸ್ಯ ಬೆಳವಣಿಗೆ ಕುಂಠಿತವಾಗುತ್ತದೆ.',
      });
    }
    if (normalized.contains('light and dark green mosaic')) {
      return _text(const {
        AppLanguage.english: 'Light and dark green mosaic pattern on leaves.',
        AppLanguage.hindi: 'पत्तियों पर हल्के और गहरे हरे मोज़ेक पैटर्न।',
        AppLanguage.malayalam: 'ഇലകളിൽ ഇളം-ഇരുണ്ട പച്ച മൊസൈക്ക് പാറ്റേൺ.',
        AppLanguage.kannada: 'ಎಲೆಗಳ ಮೇಲೆ ತೆಳು-ಗಾಢ ಹಸಿರು ಮೋಸಾಯಿಕ್ ಮಾದರಿ.',
      });
    }
    if (normalized.contains('leaf distortion and irregular blade shape')) {
      return _text(const {
        AppLanguage.english: 'Leaf distortion and irregular blade shape.',
        AppLanguage.hindi: 'पत्तियों का विकृत होना और अनियमित आकार।',
        AppLanguage.malayalam: 'ഇലയുടെ രൂപവൈകല്യവും അസമമായ ആകൃതിയും.',
        AppLanguage.kannada: 'ಎಲೆಗಳ ವಿಕೃತಿ ಮತ್ತು ಅಸಮ ಆಕಾರ.',
      });
    }
    if (normalized.contains('general stress pattern detected')) {
      return _text(const {
        AppLanguage.english: 'General stress pattern detected.',
        AppLanguage.hindi: 'सामान्य तनाव पैटर्न पाया गया।',
        AppLanguage.malayalam: 'സാധാരണ സമ്മർദ്ദ പാറ്റേൺ കണ്ടെത്തി.',
        AppLanguage.kannada: 'ಸಾಮಾನ್ಯ ಒತ್ತಡದ ಲಕ್ಷಣಗಳು ಪತ್ತೆಯಾಗಿದೆ.',
      });
    }
    if (normalized.contains('inspect nearby leaves and stem')) {
      return _text(const {
        AppLanguage.english:
            'Inspect nearby leaves and stem for progression signs.',
        AppLanguage.hindi: 'आसपास की पत्तियों और तने में बढ़ते लक्षण जांचें।',
        AppLanguage.malayalam:
            'അരികിലെ ഇലകളും തണ്ടും കൂടുതൽ ലക്ഷണങ്ങൾക്കായി പരിശോധിക്കുക.',
        AppLanguage.kannada:
            'ಪಕ್ಕದ ಎಲೆಗಳು ಮತ್ತು ಕಾಂಡವನ್ನು ಪ್ರಗತಿ ಲಕ್ಷಣಗಳಿಗಾಗಿ ಪರಿಶೀಲಿಸಿ.',
      });
    }

    return rawSymptom;
  }

  String translateRecommendation(String rawRecommendation) {
    final String normalized = rawRecommendation.toLowerCase().trim();

    if (normalized.contains('immediate action')) {
      return _text(const {
        AppLanguage.english:
            'Immediate action: Isolate plant and notify neighborhood farmers.',
        AppLanguage.hindi:
            'तुरंत कार्रवाई: संक्रमित पौधे को अलग करें और आसपास के किसानों को सूचित करें।',
        AppLanguage.malayalam:
            'ഉടൻ നടപടി: ബാധിത ചെടി വേർതിരിച്ച് സമീപ കർഷകരെ അറിയിക്കുക.',
        AppLanguage.kannada:
            'ತಕ್ಷಣ ಕ್ರಮ: ಸೋಂಕಿತ ಸಸಿಯನ್ನು ಪ್ರತ್ಯೇಕಿಸಿ ಸುತ್ತಲಿನ ರೈತರಿಗೆ ತಿಳಿಸಿ.',
      });
    }

    if (normalized.contains('plant appears healthy')) {
      return _text(const {
        AppLanguage.english:
            'Plant appears healthy. Continue regular monitoring and balanced nutrient/water management.',
        AppLanguage.hindi:
            'पौधा स्वस्थ दिखता है। नियमित निगरानी और संतुलित पोषण/सिंचाई जारी रखें।',
        AppLanguage.malayalam:
            'ചെടി ആരോഗ്യകരമാണെന്ന് തോന്നുന്നു. സ്ഥിരപരിശോധനയും സമതുലിത വളം/ജല നിയന്ത്രണവും തുടരുക.',
        AppLanguage.kannada:
            'ಸಸಿ ಆರೋಗ್ಯಕರವಾಗಿದೆ. ನಿಯಮಿತ ಮೇಲ್ವಿಚಾರಣೆ ಹಾಗೂ ಸಮತೋಲನ ಪೋಷಕಾಂಶ/ನೀರಾವರಿ ಮುಂದುವರಿಸಿ.',
      });
    }

    if (normalized.contains('likely disease symptoms detected')) {
      return _text(const {
        AppLanguage.english:
            'Likely disease symptoms detected. Isolate severely affected leaves, monitor nearby plants, and follow disease-specific control practices.',
        AppLanguage.hindi:
            'संभावित रोग लक्षण मिले हैं। अधिक प्रभावित पत्तियों को अलग करें, पास की फसलों की निगरानी करें और रोग-विशिष्ट नियंत्रण उपाय अपनाएं।',
        AppLanguage.malayalam:
            'സാധ്യതയുള്ള രോഗലക്ഷണങ്ങൾ കണ്ടെത്തി. ഗുരുതരമായി ബാധിച്ച ഇലകൾ വേർതിരിക്കുക, സമീപ ചെടികൾ നിരീക്ഷിക്കുക, രോഗാനുസൃത നിയന്ത്രണ മാർഗങ്ങൾ പിന്തുടരുക.',
        AppLanguage.kannada:
            'ಸಂಭಾವ್ಯ ರೋಗ ಲಕ್ಷಣಗಳು ಪತ್ತೆಯಾಗಿವೆ. ಹೆಚ್ಚು ബാധಿತ ಎಲೆಗಳನ್ನು ಪ್ರತ್ಯೇಕಿಸಿ, ಸುತ್ತಮುತ್ತಲಿನ ಸಸಿಗಳನ್ನು ಪರಿಶೀಲಿಸಿ, ರೋಗ-ನಿರ್ದಿಷ್ಟ ನಿಯಂತ್ರಣ ಕ್ರಮ ಅನುಸರಿಸಿ.',
      });
    }

    return rawRecommendation;
  }

  String get riskLow => _text(const {
    AppLanguage.english: 'Low',
    AppLanguage.hindi: 'कम',
    AppLanguage.malayalam: 'കുറവ്',
    AppLanguage.kannada: 'ಕಡಿಮೆ',
  });

  String get riskHigh => _text(const {
    AppLanguage.english: 'High',
    AppLanguage.hindi: 'उच्च',
    AppLanguage.malayalam: 'ഉയർന്ന',
    AppLanguage.kannada: 'ಹೆಚ್ಚು',
  });

  String get riskModerate => _text(const {
    AppLanguage.english: 'Moderate',
    AppLanguage.hindi: 'मध्यम',
    AppLanguage.malayalam: 'മധ്യം',
    AppLanguage.kannada: 'ಮಧ್ಯಮ',
  });

  String get riskNeedsManualVerification => _text(const {
    AppLanguage.english: 'Needs manual verification',
    AppLanguage.hindi: 'मैनुअल सत्यापन आवश्यक',
    AppLanguage.malayalam: 'മാനുവൽ പരിശോധന ആവശ്യം',
    AppLanguage.kannada: 'ಕೈಯಾರೆ ಪರಿಶೀಲನೆ ಅಗತ್ಯ',
  });

  String get spreadPrediction => _text(const {
    AppLanguage.english: 'Spread Prediction',
    AppLanguage.hindi: 'फैलाव पूर्वानुमान',
    AppLanguage.malayalam: 'വ്യാപന പ്രവചനം',
    AppLanguage.kannada: 'ಹರಡುವಿಕೆ ಊಹೆ',
  });

  String get active => _text(const {
    AppLanguage.english: 'Active',
    AppLanguage.hindi: 'सक्रिय',
    AppLanguage.malayalam: 'സജീവം',
    AppLanguage.kannada: 'ಸಕ್ರಿಯ',
  });

  String get paused => _text(const {
    AppLanguage.english: 'Paused',
    AppLanguage.hindi: 'रुका हुआ',
    AppLanguage.malayalam: 'നിർത്തിയിരിക്കുന്നു',
    AppLanguage.kannada: 'ನಿಲ್ಲಿಸಲಾಗಿದೆ',
  });

  String get windNotificationsStopped => _text(const {
    AppLanguage.english: 'Wind spread notifications stopped',
    AppLanguage.hindi: 'हवा फैलाव सूचनाएं बंद की गईं',
    AppLanguage.malayalam: 'കാറ്റ് വ്യാപന അറിയിപ്പുകൾ നിർത്തി',
    AppLanguage.kannada: 'ಗಾಳಿ ಹರಡುವಿಕೆ ಸೂಚನೆಗಳನ್ನು ನಿಲ್ಲಿಸಲಾಗಿದೆ',
  });

  String get windNotificationsStarted => _text(const {
    AppLanguage.english: 'Wind spread notifications started (every 10 seconds)',
    AppLanguage.hindi: 'हवा फैलाव सूचनाएं शुरू हुईं (हर 10 सेकंड)',
    AppLanguage.malayalam:
        'കാറ്റ് വ്യാപന അറിയിപ്പുകൾ തുടങ്ങി (ഓരോ 10 സെക്കൻഡിലും)',
    AppLanguage.kannada:
        'ಗಾಳಿ ಹರಡುವಿಕೆ ಸೂಚನೆಗಳು ಪ್ರಾರಂಭವಾಗಿವೆ (ಪ್ರತಿ 10 ಸೆಕೆಂಡಿಗೆ)',
  });

  String errorWithValue(String error) {
    return _text({
      AppLanguage.english: 'Error: $error',
      AppLanguage.hindi: 'त्रुटि: $error',
      AppLanguage.malayalam: 'പിശക്: $error',
      AppLanguage.kannada: 'ದೋಷ: $error',
    });
  }

  String get aiSpreadForecast => _text(const {
    AppLanguage.english: 'AI Spread Forecast',
    AppLanguage.hindi: 'एआई फैलाव पूर्वानुमान',
    AppLanguage.malayalam: 'എഐ വ്യാപന പ്രവചനം',
    AppLanguage.kannada: 'ಎಐ ಹರಡುವಿಕೆ ಊಹೆ',
  });

  String get spreadForecastSubtitle => _text(const {
    AppLanguage.english:
        'Prediction combines detected infection point and wind flow to estimate nearby risk zones.',
    AppLanguage.hindi:
        'पूर्वानुमान संक्रमित बिंदु और हवा के प्रवाह को जोड़कर आसपास के जोखिम क्षेत्र बताता है।',
    AppLanguage.malayalam:
        'കണ്ടെത്തിയ രോഗബിന്ദുവും കാറ്റിന്റെ പ്രവാഹവും ചേർത്ത് സമീപ അപകട മേഖലകൾ പ്രവചിക്കുന്നു.',
    AppLanguage.kannada:
        'ಪತ್ತೆಯಾದ ಸೋಂಕಿನ ಬಿಂದು ಮತ್ತು ಗಾಳಿಯ ಹರಿವನ್ನು ಸೇರಿಸಿ ಸಮೀಪದ ಅಪಾಯ ವಲಯಗಳನ್ನು ಅಂದಾಜಿಸುತ್ತದೆ.',
  });

  String get detectionLocationOrigin => _text(const {
    AppLanguage.english: 'Detection location (origin)',
    AppLanguage.hindi: 'पहचान स्थान (मूल बिंदु)',
    AppLanguage.malayalam: 'തിരിച്ചറിയൽ സ്ഥലം (ആരംഭബിന്ദു)',
    AppLanguage.kannada: 'ಪತ್ತೆ ಸ್ಥಳ (ಮೂಲ ಬಿಂದು)',
  });

  String get nextFiveLikelySpots => _text(const {
    AppLanguage.english: 'Next 5 likely wind spread spots',
    AppLanguage.hindi: 'अगले 5 संभावित हवा फैलाव स्थान',
    AppLanguage.malayalam: 'അടുത്ത 5 സാധ്യതയുള്ള കാറ്റ് വ്യാപന സ്ഥാനങ്ങൾ',
    AppLanguage.kannada: 'ಮುಂದಿನ 5 ಸಾಧ್ಯ ಗಾಳಿ ಹರಡುವಿಕೆ ಸ್ಥಳಗಳು',
  });

  String get retryLocationWeather => _text(const {
    AppLanguage.english: 'Retry Location & Weather',
    AppLanguage.hindi: 'स्थान और मौसम फिर से प्राप्त करें',
    AppLanguage.malayalam: 'സ്ഥലവും കാലാവസ്ഥയും വീണ്ടും പരിശോധിക്കുക',
    AppLanguage.kannada: 'ಸ್ಥಳ ಮತ್ತು ಹವಾಮಾನವನ್ನು ಮತ್ತೆ ಪಡೆಯಿರಿ',
  });

  String get windDirection => _text(const {
    AppLanguage.english: 'Wind Direction',
    AppLanguage.hindi: 'हवा की दिशा',
    AppLanguage.malayalam: 'കാറ്റിന്റെ ദിശ',
    AppLanguage.kannada: 'ಗಾಳಿಯ ದಿಕ್ಕು',
  });

  String windDirectionValue(String shortDirection, String degrees) {
    return _text({
      AppLanguage.english: '$shortDirection ($degrees deg)',
      AppLanguage.hindi: '$shortDirection ($degrees डिग्री)',
      AppLanguage.malayalam: '$shortDirection ($degrees ഡിഗ്രി)',
      AppLanguage.kannada: '$shortDirection ($degrees ಡಿಗ್ರಿ)',
    });
  }

  String get windSpeed => _text(const {
    AppLanguage.english: 'Wind Speed',
    AppLanguage.hindi: 'हवा की गति',
    AppLanguage.malayalam: 'കാറ്റിന്റെ വേഗം',
    AppLanguage.kannada: 'ಗಾಳಿಯ ವೇಗ',
  });

  String windSpeedValue(String value) {
    return _text({
      AppLanguage.english: '$value km/h',
      AppLanguage.hindi: '$value किमी/घंटा',
      AppLanguage.malayalam: '$value കിമീ/മണിക്കൂർ',
      AppLanguage.kannada: '$value ಕಿಮೀ/ಗಂ',
    });
  }

  String get spreadPageExplanation => _text(const {
    AppLanguage.english:
        'Location is requested on this page, then the app predicts and plots five likely spread spots from current wind flow.',
    AppLanguage.hindi:
        'इस पेज पर स्थान लिया जाता है, फिर ऐप वर्तमान हवा के प्रवाह से पांच संभावित फैलाव स्थान दिखाता है।',
    AppLanguage.malayalam:
        'ഈ പേജിൽ സ്ഥലം എടുക്കുകയും തുടർന്ന് നിലവിലെ കാറ്റ് പ്രവാഹത്തിൽ നിന്ന് അഞ്ചു സാധ്യതയുള്ള വ്യാപന സ്ഥലങ്ങൾ കാണിക്കുകയും ചെയ്യുന്നു.',
    AppLanguage.kannada:
        'ಈ ಪುಟದಲ್ಲಿ ಸ್ಥಳವನ್ನು ಪಡೆದು, ನಂತರ ಪ್ರಸ್ತುತ ಗಾಳಿಯ ಹರಿವಿನಿಂದ ಐದು ಸಾಧ್ಯ ಹರಡುವಿಕೆ ಸ್ಥಳಗಳನ್ನು ತೋರಿಸಲಾಗುತ್ತದೆ.',
  });

  String get sendAlert => _text(const {
    AppLanguage.english: 'Send Alert',
    AppLanguage.hindi: 'अलर्ट भेजें',
    AppLanguage.malayalam: 'അലർട്ട് അയയ്ക്കുക',
    AppLanguage.kannada: 'ಎಚ್ಚರಿಕೆ ಕಳುಹಿಸಿ',
  });

  String get locationServicesDisabled => _text(const {
    AppLanguage.english:
        'Location services are disabled. Enable GPS and try again.',
    AppLanguage.hindi:
        'स्थान सेवाएं बंद हैं। GPS चालू करें और फिर प्रयास करें।',
    AppLanguage.malayalam:
        'സ്ഥല സേവനങ്ങൾ നിർത്തിയിരിക്കുന്നു. GPS ഓണാക്കി വീണ്ടും ശ്രമിക്കുക.',
    AppLanguage.kannada:
        'ಸ್ಥಳ ಸೇವೆಗಳು ನಿಷ್ಕ್ರಿಯವಾಗಿವೆ. GPS ಸಕ್ರಿಯಗೊಳಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
  });

  String get locationPermissionDenied => _text(const {
    AppLanguage.english:
        'Location permission denied. Please allow location access.',
    AppLanguage.hindi: 'स्थान अनुमति अस्वीकृत है। कृपया स्थान की अनुमति दें।',
    AppLanguage.malayalam: 'സ്ഥലാനുമതി നിഷേധിച്ചു. ദയവായി അനുവാദം നൽകുക.',
    AppLanguage.kannada:
        'ಸ್ಥಳ ಅನುಮತಿ ನಿರಾಕರಿಸಲಾಗಿದೆ. ದಯವಿಟ್ಟು ಸ್ಥಳ ಪ್ರವೇಶವನ್ನು ಅನುಮತಿಸಿ.',
  });

  String get alertNotification => _text(const {
    AppLanguage.english: 'Alert Notification',
    AppLanguage.hindi: 'अलर्ट सूचना',
    AppLanguage.malayalam: 'അലർട്ട് അറിയിപ്പ്',
    AppLanguage.kannada: 'ಎಚ್ಚರಿಕೆ ಸೂಚನೆ',
  });

  String get highRiskAlert => _text(const {
    AppLanguage.english: 'ThripsNet High Risk Alert',
    AppLanguage.hindi: 'ThripsNet उच्च जोखिम अलर्ट',
    AppLanguage.malayalam: 'ThripsNet ഉയർന്ന അപകട അലർട്ട്',
    AppLanguage.kannada: 'ThripsNet ಹೆಚ್ಚಿನ ಅಪಾಯ ಎಚ್ಚರಿಕೆ',
  });

  String get alertSubtitle => _text(const {
    AppLanguage.english:
        'TSWV detected near your farm. Prompt intervention is recommended to reduce spread.',
    AppLanguage.hindi:
        'आपके खेत के पास TSWV पाया गया है। फैलाव कम करने के लिए तुरंत कार्रवाई करें।',
    AppLanguage.malayalam:
        'നിങ്ങളുടെ വയലിന് സമീപം TSWV കണ്ടെത്തി. വ്യാപനം കുറയ്ക്കാൻ വേഗത്തിൽ ഇടപെടുക.',
    AppLanguage.kannada:
        'ನಿಮ್ಮ ಹೊಲದ ಸಮೀಪ TSWV ಪತ್ತೆಯಾಗಿದೆ. ಹರಡುವಿಕೆಯನ್ನು ಕಡಿಮೆ ಮಾಡಲು ತಕ್ಷಣ ಕ್ರಮ ಕೈಗೊಳ್ಳಿ.',
  });

  String get northEastWind => _text(const {
    AppLanguage.english: 'North-East Wind',
    AppLanguage.hindi: 'उत्तर-पूर्वी हवा',
    AppLanguage.malayalam: 'വടക്കുകിഴക്കൻ കാറ്റ്',
    AppLanguage.kannada: 'ಉತ್ತರ-ಪೂರ್ವ ಗಾಳಿ',
  });

  String get riskRadiusTenKm => _text(const {
    AppLanguage.english: 'Risk Radius 10 km',
    AppLanguage.hindi: 'जोखिम त्रिज्या 10 किमी',
    AppLanguage.malayalam: 'അപകട പരിധി 10 കിമീ',
    AppLanguage.kannada: 'ಅಪಾಯ ವ್ಯಾಪ್ತಿ 10 ಕಿಮೀ',
  });

  String get zoneAlertsActive => _text(const {
    AppLanguage.english: 'Zone Alerts Active',
    AppLanguage.hindi: 'क्षेत्र अलर्ट सक्रिय',
    AppLanguage.malayalam: 'മേഖലാ അലർട്ടുകൾ സജീവം',
    AppLanguage.kannada: 'ವಲಯ ಎಚ್ಚರಿಕೆಗಳು ಸಕ್ರಿಯ',
  });

  String get aiGuidance => _text(const {
    AppLanguage.english: 'AI Guidance',
    AppLanguage.hindi: 'एआई मार्गदर्शन',
    AppLanguage.malayalam: 'എഐ മാർഗ്ഗനിർദ്ദേശം',
    AppLanguage.kannada: 'ಎಐ ಮಾರ್ಗದರ್ಶನ',
  });

  String get alertBullet1 => _text(const {
    AppLanguage.english:
        '• Risk notifications are now sent to farmers in the surrounding zone.',
    AppLanguage.hindi:
        '• अब आसपास के क्षेत्र के किसानों को जोखिम सूचनाएं भेजी जा रही हैं।',
    AppLanguage.malayalam:
        '• ഇപ്പോൾ ചുറ്റുമുള്ള മേഖലയിലെ കർഷകർക്ക് അപകട അറിയിപ്പുകൾ അയക്കുന്നു.',
    AppLanguage.kannada:
        '• ಈಗ ಸುತ್ತಮುತ್ತಲಿನ ವಲಯದ ರೈತರಿಗೆ ಅಪಾಯದ ಸೂಚನೆಗಳನ್ನು ಕಳುಹಿಸಲಾಗುತ್ತಿದೆ.',
  });

  String get alertBullet2 => _text(const {
    AppLanguage.english:
        '• Recommend immediate preventive action in border rows first.',
    AppLanguage.hindi:
        '• ആദ്യം किनारे की कतारों में तुरंत निवारक कार्रवाई करें।',
    AppLanguage.malayalam:
        '• ആദ്യം അതിര്‍ത്തി നിരകളിൽ ഉടൻ പ്രതിരോധ നടപടി സ്വീകരിക്കുക.',
    AppLanguage.kannada:
        '• ಮೊದಲು ಗಡಿ ಸಾಲುಗಳಲ್ಲಿ ತಕ್ಷಣ ತಡೆ ಕ್ರಮ ಕೈಗೊಳ್ಳಲು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.',
  });

  String get alertBullet3 => _text(const {
    AppLanguage.english:
        '• Open disease guide for language-specific treatment steps.',
    AppLanguage.hindi: '• भाषा-विशिष्ट उपचार कदमों के लिए रोग गाइड खोलें।',
    AppLanguage.malayalam:
        '• ഭാഷാനുസൃത ചികിത്സാ ഘട്ടങ്ങൾക്കായി രോഗ ഗൈഡ് തുറക്കുക.',
    AppLanguage.kannada:
        '• ಭಾಷಾ-ನಿರ್ದಿಷ್ಟ ಚಿಕಿತ್ಸಾ ಹಂತಗಳಿಗಾಗಿ ರೋಗ ಮಾರ್ಗದರ್ಶಿ ತೆರೆಯಿರಿ.',
  });

  String get openPreventiveMeasures => _text(const {
    AppLanguage.english: 'Open Preventive Measures',
    AppLanguage.hindi: 'निवारक उपाय खोलें',
    AppLanguage.malayalam: 'പ്രതിരോധ നടപടികൾ തുറക്കുക',
    AppLanguage.kannada: 'ತಡೆ ಕ್ರಮಗಳನ್ನು ತೆರೆಯಿರಿ',
  });

  String get diseaseInformation => _text(const {
    AppLanguage.english: 'Disease Information',
    AppLanguage.hindi: 'रोग जानकारी',
    AppLanguage.malayalam: 'രോഗ വിവരം',
    AppLanguage.kannada: 'ರೋಗ ಮಾಹಿತಿ',
  });

  String get aiKnowledge => _text(const {
    AppLanguage.english: 'AI Knowledge',
    AppLanguage.hindi: 'एआई ज्ञान',
    AppLanguage.malayalam: 'എഐ അറിവ്',
    AppLanguage.kannada: 'ಎಐ ಜ್ಞಾನ',
  });

  String get diseaseHeroSubtitle => _text(const {
    AppLanguage.english:
        'Review symptoms and apply preventive actions quickly to protect surrounding crops.',
    AppLanguage.hindi:
        'लक्षण देखें और आसपास की फसलों की रक्षा के लिए जल्दी निवारक कदम उठाएं।',
    AppLanguage.malayalam:
        'ലക്ഷണങ്ങൾ പരിശോധിച്ച് ചുറ്റുമുള്ള വിളകളെ സംരക്ഷിക്കാൻ വേഗത്തിൽ പ്രതിരോധ നടപടി സ്വീകരിക്കുക.',
    AppLanguage.kannada:
        'ಸುತ್ತಲಿನ ಬೆಳೆಗಳನ್ನು ರಕ್ಷಿಸಲು ಲಕ್ಷಣಗಳನ್ನು ಪರಿಶೀಲಿಸಿ ಮತ್ತು ತಕ್ಷಣ ತಡೆ ಕ್ರಮ ಅನುಸರಿಸಿ.',
  });

  String get listen => _text(const {
    AppLanguage.english: 'Listen',
    AppLanguage.hindi: 'सुनें',
    AppLanguage.malayalam: 'ശ്രവിക്കുക',
    AppLanguage.kannada: 'ಆಲಿಸಿ',
  });

  String get stopAudio => _text(const {
    AppLanguage.english: 'Stop Audio',
    AppLanguage.hindi: 'ऑडियो रोकें',
    AppLanguage.malayalam: 'ഓഡിയോ നിർത്തുക',
    AppLanguage.kannada: 'ಆಡಿಯೋ ನಿಲ್ಲಿಸಿ',
  });

  String get couldNotStartVoice => _text(const {
    AppLanguage.english:
        'Could not start voice. Open phone settings > Text-to-speech output and set an engine/voice.',
    AppLanguage.hindi:
        'आवाज़ शुरू नहीं हुई। फोन सेटिंग्स > टेक्स्ट-टू-स्पीच आउटपुट में इंजन या आवाज़ सेट करें।',
    AppLanguage.malayalam:
        'ശബ്‌ദം ആരംഭിക്കാനായില്ല. ഫോൺ ക്രമീകരണങ്ങൾ > ടെക്സ്റ്റ്-ടു-സ്പീച്ച് ഔട്ട്പുട്ടിൽ എൻജിൻ അല്ലെങ്കിൽ ശബ്ദം സജ്ജമാക്കുക.',
    AppLanguage.kannada:
        'ಧ್ವನಿ ಪ್ರಾರಂಭವಾಗಲಿಲ್ಲ. ಫೋನ್ ಸೆಟ್ಟಿಂಗ್‌ಗಳು > ಪಠ್ಯದಿಂದ ಧ್ವನಿ ಔಟ್‌ಪುಟ್‌ನಲ್ಲಿ ಎಂಜಿನ್ ಅಥವಾ ಧ್ವನಿಯನ್ನು ಹೊಂದಿಸಿ.',
  });

  String audioFinished(String languageLabel) {
    return _text({
      AppLanguage.english: 'Finished audio in $languageLabel.',
      AppLanguage.hindi: '$languageLabel में ऑडियो पूरा हुआ।',
      AppLanguage.malayalam: '$languageLabel ഭാഷയിലെ ഓഡിയോ പൂർത്തിയായി.',
      AppLanguage.kannada: '$languageLabel ಭಾಷೆಯ ಆಡಿಯೋ ಪೂರ್ಣಗೊಂಡಿದೆ.',
    });
  }

  String get voicePlaybackFailed => _text(const {
    AppLanguage.english:
        'Voice playback failed. Please verify Text-to-speech output in phone settings.',
    AppLanguage.hindi:
        'आवाज़ चलाने में विफलता हुई। कृपया फोन सेटिंग्स में टेक्स्ट-टू-स्पीच आउटपुट जांचें।',
    AppLanguage.malayalam:
        'ശബ്ദ പ്ലേബാക്ക് പരാജയപ്പെട്ടു. ഫോൺ ക്രമീകരണങ്ങളിലെ ടെക്സ്റ്റ്-ടു-സ്പീച്ച് ഔട്ട്പുട്ട് പരിശോധിക്കുക.',
    AppLanguage.kannada:
        'ಧ್ವನಿ ಪ್ಲೇಬ್ಯಾಕ್ ವಿಫಲವಾಯಿತು. ಫೋನ್ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿನ ಪಠ್ಯ-ಧ್ವನಿ ಔಟ್‌ಪುಟ್ ಪರಿಶೀಲಿಸಿ.',
  });
}
