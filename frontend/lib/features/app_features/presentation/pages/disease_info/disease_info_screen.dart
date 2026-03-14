import 'package:flutter/material.dart';

import '../../../../../../common/app_theme.dart';
import '../../../../../common/app_tts_service.dart';

class DiseaseInfoScreen extends StatefulWidget {
  const DiseaseInfoScreen({super.key});

  @override
  State<DiseaseInfoScreen> createState() => _DiseaseInfoScreenState();
}

class _DiseaseInfoScreenState extends State<DiseaseInfoScreen> {
  String _selectedLanguage = 'English';
  final AppTtsService _ttsService = AppTtsService();
  bool _isSpeaking = false;
  int _speakRequestId = 0;
  final Map<String, String> _languageLabels = const {
    'English': 'EN',
    'Hindi': 'HIN',
    'Malayalam': 'M',
    'Kannada': 'KAN',
  };

  @override
  void initState() {
    super.initState();
    _ttsService.init();
  }

  Future<void> _onListenTap() async {
    if (_isSpeaking) {
      _speakRequestId++;
      await _ttsService.stop();
      if (mounted) {
        setState(() {
          _isSpeaking = false;
        });
      }
      return;
    }

    await _listen();
  }

  Future<void> _listen() async {
    final LocalizedContent content = _getContentForLanguage(_selectedLanguage);
    final String fullText = _buildSpeechTextFromDisplayedContent(content);
    final int requestId = ++_speakRequestId;

    try {
      if (_isSpeaking) {
        await _ttsService.stop();
      }

      setState(() {
        _isSpeaking = true;
      });

      final AppTtsSpeakResult result = await _ttsService.speak(
        text: fullText,
        appLanguageCode: _languageKey(_selectedLanguage),
      );

      // Ignore stale completions from a previously interrupted request.
      if (requestId != _speakRequestId) {
        return;
      }

      if (!result.started && mounted) {
        setState(() {
          _isSpeaking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not start voice. Open phone settings > Text-to-speech output and set an engine/voice.'),
          ),
        );
        return;
      }

      if (mounted) {
        setState(() {
          _isSpeaking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Finished audio in ${result.languageLabel}.')));
      }
    } catch (_) {
      if (requestId != _speakRequestId) {
        return;
      }
      if (mounted) {
        setState(() {
          _isSpeaking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Voice playback failed. Please verify Text-to-speech output in phone settings.'),
          ),
        );
      }
    }
  }

  String _buildSpeechTextFromDisplayedContent(LocalizedContent content) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln(content.disease);
    buffer.writeln();
    buffer.writeln(content.symptomsHeader);
    for (final String symptom in content.symptoms) {
      buffer.writeln('• $symptom');
    }
    buffer.writeln();
    buffer.writeln(content.preventiveHeader);
    for (final MeasureSection section in content.measures) {
      buffer.writeln(section.title);
      for (final String step in section.steps) {
        buffer.writeln('• $step');
      }
      buffer.writeln();
    }
    buffer.writeln(content.tipHeader);
    buffer.writeln(content.tipBody);
    return buffer.toString();
  }

  Widget _heroChip({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x28FFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x44FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _languageKey(String language) {
    switch (language) {
      case 'Malayalam':
        return 'ml';
      case 'Hindi':
        return 'hi';
      case 'Kannada':
        return 'kn';
      default:
        return 'en';
    }
  }

  LocalizedContent _getContentForLanguage(String language) {
    switch (language) {
      case 'Kannada':
        return const LocalizedContent(
          disease: 'ಟೊಮ್ಯಾಟೊ ಸ್ಪಾಟೆಡ್ ವಿಲ್ಟ್ ವೈರಸ್ (TSWV)',
          symptomsHeader: 'ಲಕ್ಷಣಗಳು',
          symptoms: [
            'ವಲಯಾಕಾರದ ಕಲೆಗಳು',
            'ಎಲೆಗಳಲ್ಲಿ ಕಂಚಿನ ಬಣ್ಣ',
            'ಕುಂಠಿತ ಬೆಳವಣಿಗೆ',
          ],
          preventiveHeader: 'ತಡೆಗಟ್ಟುವ ಕ್ರಮಗಳು',
          measures: [
            MeasureSection(
              title: '1. ನೀಲಿ ಸ್ಟಿಕ್ಕಿ ಟ್ರ್ಯಾಪ್‌ಗಳನ್ನು ಅಳವಡಿಸಿ (ತಕ್ಷಣ ಮಾಡಿರಿ)',
              steps: [
                'ಕೃಷಿ ಅಂಗಡಿಯಿಂದ ನೀಲಿ ಅಥವಾ ಹಳದಿ ಸ್ಟಿಕ್ಕಿ ಟ್ರ್ಯಾಪ್‌ಗಳನ್ನು ಖರೀದಿಸಿ',
                'ನಿಮ್ಮ ಹೊಲದಲ್ಲಿ ಪ್ರತಿ ಏಕರಿಗೆ ಸುಮಾರು 40 ಟ್ರ್ಯಾಪ್‌ಗಳನ್ನು ಇರಿಸಿ',
                'ಟ್ರ್ಯಾಪ್‌ಗಳನ್ನು ಸಣ್ಣ ಕಡ್ಡಿಗಳ ಮೇಲೆ ಅಳವಡಿಸಿ',
                'ಟ್ರ್ಯಾಪ್‌ಗಳನ್ನು ಬೆಳೆ ಎಲೆಗಳ ಸಮಾನ ಎತ್ತರದಲ್ಲಿ ಇಡಿ',
                'ಟ್ರ್ಯಾಪ್‌ಗಳನ್ನು ಹೊಲದಾದ್ಯಂತ ಸಮವಾಗಿ ಹಂಚಿ',
              ],
            ),
            MeasureSection(
              title: '2. ಅಂಚಿನ ಸಸಿಗಳ ಮೇಲೆ ನೀಮ್ ಎಣ್ಣೆ ಸಿಂಪಡಿಸಿ (ಸೂರ್ಯಾಸ್ತಕ್ಕೂ ಮುನ್ನ)',
              steps: [
                'ನೀಮ್ ಎಣ್ಣೆ (Azadirachtin) ಅಥವಾ Spinosad ಕೀಟನಾಶಕ ದ್ರಾವಣವನ್ನು ತಯಾರಿಸಿ',
                'ಬಾಟಲಿಯ ಮೇಲಿನ ಸೂಚನೆಗಳಂತೆ ದ್ರಾವಣವನ್ನು ಮಿಶ್ರಣ ಮಾಡಿ',
                'ಹೊಲದ ಸುತ್ತಲಿನ ಮೊದಲ 5 ಸಾಲಿನ ಸಸಿಗಳ ಮೇಲೆ ಮಾತ್ರ ಸಿಂಪಡಿಸಿ',
                'ಗಾಳಿ ಬರುವ ದಿಕ್ಕಿನ ಭಾಗಕ್ಕೆ ವಿಶೇಷ ಗಮನ ನೀಡಿ',
                'ಸಂಜೆ ಸೂರ್ಯಾಸ್ತಕ್ಕೂ ಮೊದಲು ಸಿಂಪಡಿಸಿ',
              ],
            ),
            MeasureSection(
              title: '3. ಹೊಲದ ಸುತ್ತಲಿನ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ',
              steps: [
                'ನಿಮ್ಮ ಬೆಳೆ ಹೊಲದ ಸುತ್ತಲಿನ ಪ್ರದೇಶವನ್ನು ಪರಿಶೀಲಿಸಿ',
                'ಹೊಲದ ಸುತ್ತ 2 ಮೀಟರ್ ವ್ಯಾಪ್ತಿಯಲ್ಲಿರುವ ಎಲ್ಲಾ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ',
                'ಕೈಯಿಂದ ಎಳೆಯಿರಿ ಅಥವಾ ಉಪಕರಣಗಳಿಂದ ಕತ್ತರಿಸಿ',
                'ವಿಶೇಷವಾಗಿ Parthenium ಮತ್ತು Amaranthusಂತಹ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ',
                'ತೆಗೆದ ಕಳೆಗಳನ್ನು ಬೆಳೆ ಪ್ರದೇಶದಿಂದ ದೂರದಲ್ಲಿ ತ್ಯಜಿಸಿ',
              ],
            ),
            MeasureSection(
              title: '4. ಲಭ್ಯವಿದ್ದರೆ ಸ್ಪ್ರಿಂಕ್ಲರ್ ಬಳಸಿ (ಐಚ್ಛಿಕ)',
              steps: [
                'ನಿಮ್ಮ ಹೊಲದಲ್ಲಿ ಮೇಲ್ಚಾವಣಿ ಸ್ಪ್ರಿಂಕ್ಲರ್‌ಗಳು ಇದ್ದರೆ, ಅವನ್ನು ಆನ್ ಮಾಡಿ',
                'ಸ್ಪ್ರಿಂಕ್ಲರ್‌ಗಳನ್ನು ಸುಮಾರು 20 ನಿಮಿಷಗಳ ಕಾಲ ಚಾಲನೆ ಮಾಡಿ',
              ],
            ),
          ],
          tipHeader: 'ಮುಖ್ಯ ಸಲಹೆ',
          tipBody:
              'ನಿಮ್ಮ ಸಸಿಗಳನ್ನು ಪ್ರತಿದಿನ ಪರಿಶೀಲಿಸಿ. ವಲಯ ಕಲೆಗಳು, ಬ್ರೋನ್ಜಿಂಗ್ ಅಥವಾ ದುರ್ಬಲ ಸಸಿಗಳು ಕಂಡುಬಂದರೆ, ರೋಗ ಹರಡುವುದನ್ನು ತಡೆಯಲು ಅವನ್ನು ತಕ್ಷಣ ತೆಗೆದುಹಾಕಿ.',
        );
      case 'Malayalam':
        return const LocalizedContent(
          disease: 'തക്കാളി സ്പോട്ടഡ് വിൽറ്റ് വൈറസ് (TSWV)',
          symptomsHeader: 'രോഗലക്ഷണങ്ങൾ',
          symptoms: [
            'വളയാകൃതിയിലുള്ള പാടുകൾ',
            'ഇലകളിൽ വെങ്കല നിറം',
            'തടസ്സപ്പെട്ട വളർച്ച',
          ],
          preventiveHeader: 'പ്രതിരോധ നടപടികൾ',
          measures: [
            MeasureSection(
              title: '1. നീല സ്റ്റിക്കി ട്രാപ്പുകൾ സ്ഥാപിക്കുക (ഉടൻ ചെയ്യുക)',
              steps: [
                'കൃഷി കടയിൽ നിന്ന് നീല അല്ലെങ്കിൽ മഞ്ഞ സ്റ്റിക്കി ട്രാപ്പുകൾ വാങ്ങുക',
                'ഒരു ഏക്കറിന് ഏകദേശം 40 ട്രാപ്പുകൾ വയലിൽ സ്ഥാപിക്കുക',
                'ചെറിയ സ്റ്റിക്കുകളിൽ ട്രാപ്പുകൾ ഘടിപ്പിക്കുക',
                'വിളയുടെ ഇല ഉയരത്തിൽ ട്രാപ്പുകൾ വെക്കുക',
                'ട്രാപ്പുകൾ വയലിൽ ഒപ്പത്തിനൊപ്പം വിതരണപ്പെടുത്തുക',
              ],
            ),
            MeasureSection(
              title: '2. അതിർത്തി ചെടികളിൽ നീം ഓയിൽ സ്പ്രേ ചെയ്യുക (സൂര്യാസ്തമയത്തിന് മുൻപ്)',
              steps: [
                'നീം ഓയിൽ (Azadirachtin) അല്ലെങ്കിൽ Spinosad സ്പ്രേ തയ്യാറാക്കുക',
                'ബോട്ടിലിലെ നിർദ്ദേശപ്രകാരം മിശ്രിതം തയ്യാറാക്കുക',
                'വയലിന്റെ ചുറ്റും ആദ്യ 5 വരികളിൽ മാത്രം സ്പ്രേ ചെയ്യുക',
                'കാറ്റ് വരുന്ന ദിശയിലുള്ള വശത്ത് കൂടുതൽ ശ്രദ്ധിക്കുക',
                'വൈകുന്നേരം സൂര്യാസ്തമയത്തിന് മുൻപ് സ്പ്രേ ചെയ്യുക',
              ],
            ),
            MeasureSection(
              title: '3. വയലിന് ചുറ്റുമുള്ള പുല്ലുകൾ നീക്കം ചെയ്യുക',
              steps: [
                'വിള വയലിന്റെ ചുറ്റുമുള്ള പ്രദേശം പരിശോധിക്കുക',
                'വയലിന് ചുറ്റും 2 മീറ്റർ പരിധിയിൽ എല്ലാ പുല്ലുകളും നീക്കം ചെയ്യുക',
                'കൈകൊണ്ട് പറിച്ചോ ഉപകരണങ്ങൾ ഉപയോഗിച്ചോ നീക്കം ചെയ്യുക',
                'Parthenium, Amaranthus പോലുള്ള പുല്ലുകൾ പ്രത്യേകമായി നീക്കം ചെയ്യുക',
                'പുല്ലുകൾ വിള പ്രദേശത്തിൽ നിന്ന് അകലെയാക്കി കളയുക',
              ],
            ),
            MeasureSection(
              title: '4. സ്പ്രിങ്ക്ലറുകൾ ഉണ്ടെങ്കിൽ ഉപയോഗിക്കുക (ഐച്ഛികം)',
              steps: [
                'ഓവർഹെഡ് സ്പ്രിങ്ക്ലറുകൾ ഉണ്ടെങ്കിൽ ഓൺ ചെയ്യുക',
                'ഏകദേശം 20 മിനിറ്റ് സ്പ്രിങ്ക്ലറുകൾ പ്രവർത്തിപ്പിക്കുക',
              ],
            ),
          ],
          tipHeader: 'പ്രധാന നിർദേശം',
          tipBody:
              'ദിവസവും ചെടികൾ പരിശോധിക്കുക. വളയ പാടുകൾ, ബ്രോൺസിംഗ്, അല്ലെങ്കിൽ ദുർബലമായ ചെടികൾ കണ്ടാൽ രോഗവ്യാപനം തടയാൻ അവ ഉടൻ നീക്കം ചെയ്യുക.',
        );
      case 'Hindi':
        return const LocalizedContent(
          disease: 'टमाटर स्पॉटेड विल्ट वायरस (TSWV)',
          symptomsHeader: 'लक्षण',
          symptoms: [
            'वलय के आकार के धब्बे',
            'पत्तियों में कांस्य रंग',
            'कमजोर या रुकी हुई वृद्धि',
          ],
          preventiveHeader: 'निवारक उपाय',
          measures: [
            MeasureSection(
              title: '1. नीले स्टिकी ट्रैप लगाएं (तुरंत करें)',
              steps: [
                'कृषि दुकान से नीले या पीले स्टिकी ट्रैप खरीदें',
                'खेत में प्रति एकड़ लगभग 40 ट्रैप लगाएं',
                'ट्रैप को छोटी लकड़ी की डंडियों पर लगाएं',
                'ट्रैप की ऊंचाई फसल की पत्तियों के बराबर रखें',
                'ट्रैप पूरे खेत में समान रूप से फैलाएं',
              ],
            ),
            MeasureSection(
              title: '2. बॉर्डर पौधों पर नीम तेल छिड़कें (सूर्यास्त से पहले)',
              steps: [
                'नीम तेल (Azadirachtin) या Spinosad कीटनाशक घोल तैयार करें',
                'बोतल के निर्देशानुसार घोल मिलाएं',
                'खेत के चारों ओर केवल पहली 5 कतारों पर छिड़काव करें',
                'जिस दिशा से हवा आ रही है, उस तरफ विशेष ध्यान दें',
                'शाम को सूर्यास्त से पहले छिड़काव करें',
              ],
            ),
            MeasureSection(
              title: '3. खेत के आसपास की खरपतवार हटाएं',
              steps: [
                'फसल के आसपास का क्षेत्र जांचें',
                'खेत के चारों ओर 2 मीटर के भीतर सभी खरपतवार हटाएं',
                'हाथ से उखाड़ें या औजार से काटें',
                'Parthenium और Amaranthus जैसी खरपतवार जरूर हटाएं',
                'हटाई गई खरपतवार को खेत से दूर फेंकें',
              ],
            ),
            MeasureSection(
              title: '4. स्प्रिंकलर उपलब्ध हों तो चलाएं (वैकल्पिक)',
              steps: [
                'यदि ओवरहेड स्प्रिंकलर हैं, तो उन्हें चालू करें',
                'स्प्रिंकलर लगभग 20 मिनट तक चलाएं',
              ],
            ),
          ],
          tipHeader: 'महत्वपूर्ण सुझाव',
          tipBody:
              'अपने पौधों की रोज जांच करें। यदि रिंग स्पॉट, ब्रॉन्जिंग या कमजोर पौधे दिखें तो रोग फैलने से रोकने के लिए उन्हें तुरंत हटा दें।',
        );
      default:
        return const LocalizedContent(
          disease: 'Tomato Spotted Wilt Virus (TSWV)',
          symptomsHeader: 'Symptoms',
          symptoms: [
            'Ring spots',
            'Leaf bronzing',
            'Stunted growth',
          ],
          preventiveHeader: 'Preventive Measures',
          measures: [
            MeasureSection(
              title: '1.Install Blue Sticky Traps (Do this immediately)',
              steps: [
                'Buy blue or yellow sticky traps from an agriculture shop',
                'Place about 40 traps per acre in your field',
                'Fix the traps on small sticks',
                'Keep the traps at the same height as the crop leaves',
                'Spread the traps evenly across the field',
              ],
            ),
            MeasureSection(
              title: '2.Spray Neem Oil on Border Plants (Before sunset)',
              steps: [
                'Prepare a Neem oil spray (Azadirachtin) or Spinosad insecticide',
                'Mix the spray according to the instructions on the bottle',
                'Spray only the first 5 rows of plants around the field',
                'Focus especially on the side where the wind is coming from',
                'Spray in the evening before sunset',
              ],
            ),
            MeasureSection(
              title: '3.Remove Weeds Around the Field',
              steps: [
                'Check the area around your crop field',
                'Remove all weeds within 2 meters around the field',
                'Pull them out by hand or cut them using tools',
                'Especially remove weeds like Parthenium and Amaranthus',
                'Throw the weeds away from the crop area',
              ],
            ),
            MeasureSection(
              title: '4.Use Sprinklers if Available (Optional)',
              steps: [
                'If your field has overhead sprinklers, turn them on',
                'Run the sprinklers for about 20 minutes',
              ],
            ),
          ],
          tipHeader: 'Important Tip',
          tipBody:
              'Check your plants daily. If you see ring spots, bronzing, or weak plants, remove those plants immediately to stop the disease from spreading.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final LocalizedContent content = _getContentForLanguage(_selectedLanguage);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disease Information',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton<String>(
              tooltip: 'Change language',
              onSelected: (String language) async {
                if (language == _selectedLanguage) {
                  return;
                }

                // Cancel current playback when switching the spoken language.
                _speakRequestId++;
                await _ttsService.stop();

                if (!mounted) {
                  return;
                }

                setState(() {
                  _isSpeaking = false;
                  _selectedLanguage = language;
                });
              },
              itemBuilder: (BuildContext context) {
                return _languageLabels.entries
                    .where((MapEntry<String, String> entry) => entry.key != _selectedLanguage)
                    .map(
                      (MapEntry<String, String> entry) => PopupMenuItem<String>(
                        value: entry.key,
                        child: Row(
                          children: [
                            Text(
                              entry.value,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            Text(entry.key),
                          ],
                        ),
                      ),
                    )
                    .toList();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.blue.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(
                      _languageLabels[_selectedLanguage] ?? 'EN',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF62CA98), Color(0xFF9EDFC0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2455BD8C),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _heroChip(icon: Icons.smart_toy_rounded, text: 'AI Knowledge'),
                    _heroChip(icon: Icons.translate_rounded, text: _languageLabels[_selectedLanguage] ?? 'EN'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  content.disease,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Review symptoms and apply preventive actions quickly to protect surrounding crops.',
                  style: TextStyle(
                    color: Color(0xFFF2FFF7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: AppColors.softBlue,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.biotech_rounded, color: AppColors.mintDeep),
                      const SizedBox(width: 8),
                      Text(
                        content.symptomsHeader,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...content.symptoms.map(
                    (String symptom) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text('• $symptom', style: const TextStyle(fontSize: 15.2)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: AppColors.softGreen,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.shield_outlined, color: AppColors.mintDeep),
                      const SizedBox(width: 8),
                      Text(
                        content.preventiveHeader,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildPreventiveMeasures(content),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: AppColors.softYellow,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lightbulb_outline_rounded, color: AppColors.textPrimary),
                      const SizedBox(width: 8),
                      Text(
                        content.tipHeader,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(content.tipBody, style: const TextStyle(fontSize: 15.2)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _onListenTap,
            style: FilledButton.styleFrom(backgroundColor: AppColors.blue),
            icon: Icon(_isSpeaking ? Icons.stop_circle_outlined : Icons.volume_up_rounded),
            label: Text(_isSpeaking ? 'Stop Audio' : 'Listen'),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventiveMeasures(LocalizedContent content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.measures
          .map(
            (MeasureSection section) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderSoft),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    ...section.steps.map(
                      (String step) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('• $step', style: const TextStyle(height: 1.3)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}

class LocalizedContent {
  final String disease;
  final String symptomsHeader;
  final List<String> symptoms;
  final String preventiveHeader;
  final List<MeasureSection> measures;
  final String tipHeader;
  final String tipBody;

  const LocalizedContent({
    required this.disease,
    required this.symptomsHeader,
    required this.symptoms,
    required this.preventiveHeader,
    required this.measures,
    required this.tipHeader,
    required this.tipBody,
  });
}

class MeasureSection {
  final String title;
  final List<String> steps;

  const MeasureSection({required this.title, required this.steps});
}
