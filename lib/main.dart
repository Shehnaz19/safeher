import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SafeHerApp());
}

const Color purple = Color(0xFF7541A8);
const Color pink = Color(0xFFF3A6C8);
const Color palePink = Color(0xFFFFF1F7);

class SafeHerApp extends StatelessWidget {
  const SafeHerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeHer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purple, primary: purple),
        scaffoldBackgroundColor: palePink,
        appBarTheme: const AppBarTheme(
          backgroundColor: purple,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/contacts': (context) => const ContactsScreen(),
        '/tips': (context) => const TipsScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}

// ---------------- NAVIGATION DRAWER ----------------

class SafeHerDrawer extends StatelessWidget {
  const SafeHerDrawer({super.key});

  void openPage(BuildContext context, String route) {
    Navigator.pop(context);

    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [purple, Color(0xFFB36BD6)]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield_outlined, color: Colors.white, size: 48),
                SizedBox(height: 8),
                Text(
                  'SafeHer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Your safety matters',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          _item(context, Icons.home, 'Home', '/'),
          _item(
            context,
            Icons.contact_phone,
            'Emergency Contacts',
            '/contacts',
          ),
          _item(context, Icons.health_and_safety, 'Safety Tips', '/tips'),
          _item(context, Icons.support_agent, 'Resources', '/resources'),
          _item(context, Icons.info_outline, 'About SafeHer', '/about'),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon, color: purple),
      title: Text(label),
      onTap: () => openPage(context, route),
    );
  }
}

// ---------------- HOME SCREEN ----------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // SOS DEMO: displays a dialog but does not send a real alert.
  void _showSosDemo(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.shield, color: Colors.red, size: 52),
          title: const Text('SOS Demo Activated', textAlign: TextAlign.center),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This is a demonstration of the SafeHer SOS feature.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'No emergency call was made. '
                'No alert was sent, and your location was not shared.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text(
                'If you are in immediate danger in India, '
                'call 112 when it is safe to do so.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SafeHer')),
      drawer: const SafeHerDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.shield_rounded, size: 85, color: purple),
          const SizedBox(height: 12),
          const Text(
            'Your Safety, Your Strength',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Information, guidance and resources to help '
            'you make safer choices.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Icon(Icons.emergency, size: 42, color: Colors.red),
                  const SizedBox(height: 8),
                  const Text(
                    'Need help?',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'If you are in immediate danger in India, '
                    'call 112 when it is safe to do so.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // UPDATED SOS BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _showSosDemo(context),
                      icon: const Icon(Icons.shield),
                      label: const Text('SOS Demo'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contacts');
                    },
                    icon: const Icon(Icons.people),
                    label: const Text('My Trusted Contacts'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Explore SafeHer',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _quickLink(
            context,
            Icons.contact_phone,
            'Emergency Contacts',
            '/contacts',
          ),
          _quickLink(context, Icons.health_and_safety, 'Safety Tips', '/tips'),
          _quickLink(
            context,
            Icons.support_agent,
            'Support Resources',
            '/resources',
          ),
          _quickLink(context, Icons.info_outline, 'About SafeHer', '/about'),
        ],
      ),
    );
  }

  Widget _quickLink(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: purple, size: 30),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}

// ---------------- TRUSTED CONTACTS ----------------

class TrustedContact {
  final String name;
  final String phone;

  const TrustedContact({required this.name, required this.phone});
}

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  static const String storageKey = 'safeher_trusted_contacts';

  List<TrustedContact> contacts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(storageKey) ?? [];

      final loadedContacts = saved.map((entry) {
        final decoded = Uri.splitQueryString(entry);

        return TrustedContact(
          name: decoded['name'] ?? '',
          phone: decoded['phone'] ?? '',
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        contacts = loadedContacts;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not load saved contacts.')),
      );
    }
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();

    final saved = contacts.map((contact) {
      return 'name=${Uri.encodeQueryComponent(contact.name)}'
          '&phone=${Uri.encodeQueryComponent(contact.phone)}';
    }).toList();

    await prefs.setStringList(storageKey, saved);
  }

  Future<void> _addContact() async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final contact = await showDialog<TrustedContact>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add trusted contact'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Contact name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final phone = value?.trim() ?? '';

                      if (phone.isEmpty) {
                        return 'Enter a phone number';
                      }

                      final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');

                      if (digits.length < 7 || digits.length > 15) {
                        return 'Enter a valid phone number';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(
                    dialogContext,
                    TrustedContact(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                    ),
                  );
                }
              },
              child: const Text('Save contact'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    phoneController.dispose();

    if (contact == null || !mounted) return;

    setState(() => contacts.add(contact));

    try {
      await _saveContacts();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact saved on this device.')),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() => contacts.remove(contact));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not save contact.')));
    }
  }

  Future<void> _deleteContact(int index) async {
    final removed = contacts[index];

    setState(() => contacts.removeAt(index));

    try {
      await _saveContacts();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${removed.name} deleted.')));
    } catch (_) {
      if (!mounted) return;

      setState(() => contacts.insert(index, removed));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not delete contact.')),
      );
    }
  }

  Future<void> _callContact(TrustedContact contact) async {
    final phone = contact.phone.replaceAll(RegExp(r'[\s()-]'), '');

    final uri = Uri(scheme: 'tel', path: phone);

    try {
      final launched = await launchUrl(uri);

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This device cannot open the phone dialer.'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Calling is not supported in this browser or device.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Contacts')),
      drawer: const SafeHerDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addContact,
        backgroundColor: purple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Contact'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(18),
              children: [
                const Icon(Icons.contact_phone, size: 64, color: purple),
                const SizedBox(height: 8),
                const Text(
                  'Your trusted people',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Save people you trust so their numbers are '
                  'easy to find. Contacts are stored on this device.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Card(
                  color: Colors.white,
                  child: const ListTile(
                    leading: Icon(Icons.emergency, color: Colors.red),
                    title: Text('Emergency services in India'),
                    subtitle: Text(
                      '112 — call when you need emergency assistance.',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (contacts.isEmpty)
                  const Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(Icons.people_outline, size: 48, color: purple),
                          SizedBox(height: 12),
                          Text(
                            'No trusted contacts yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tap Add Contact to save your first contact.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...contacts.asMap().entries.map((entry) {
                    final index = entry.key;
                    final contact = entry.value;

                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: pink,
                          child: Text(
                            contact.name.isNotEmpty
                                ? contact.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(color: purple),
                          ),
                        ),
                        title: Text(contact.name),
                        subtitle: Text(contact.phone),
                        trailing: Wrap(
                          spacing: 0,
                          children: [
                            IconButton(
                              tooltip: 'Call contact',
                              onPressed: () => _callContact(contact),
                              icon: const Icon(Icons.call, color: Colors.green),
                            ),
                            IconButton(
                              tooltip: 'Delete contact',
                              onPressed: () => _deleteContact(index),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                const SizedBox(height: 80),
              ],
            ),
    );
  }
}

// ---------------- SAFETY TIPS ----------------

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'Safety Tips',
      icon: Icons.health_and_safety,
      subtitle: 'Practical ideas for everyday situations.',
      sections: [
        InfoSection(
          title: 'Travel safety',
          body:
              'Plan your route, use trusted transport when possible, '
              'keep your phone charged, and let someone you trust know '
              'your plans if you feel it is appropriate.',
          icon: Icons.directions_bus,
        ),
        InfoSection(
          title: 'Online safety',
          body:
              'Use strong unique passwords, enable two-factor '
              'authentication, review location-sharing settings, and '
              'avoid sharing sensitive personal details publicly.',
          icon: Icons.lock_outline,
        ),
        InfoSection(
          title: 'Public places',
          body:
              'Choose a place where you feel safer, stay aware of '
              'available exits, and seek help from trusted staff or '
              'nearby people if you feel threatened.',
          icon: Icons.people_outline,
        ),
        InfoSection(
          title: 'Trust your judgment',
          body:
              'If a situation feels unsafe, move toward a safer place '
              'when possible and contact someone you trust.',
          icon: Icons.favorite_outline,
        ),
      ],
    );
  }
}

// ---------------- SUPPORT RESOURCES ----------------

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'Support Resources',
      icon: Icons.support_agent,
      subtitle: 'Know where to look for additional support.',
      sections: [
        InfoSection(
          title: 'Emergency assistance',
          body:
              'India emergency number: 112. In immediate danger, '
              'contact local emergency services when safe.',
          icon: Icons.emergency,
        ),
        InfoSection(
          title: 'Women’s support services',
          body:
              'Look for official state women’s helplines, One Stop '
              'Centres, and government support services. Confirm current '
              'contact details through official sources.',
          icon: Icons.support,
        ),
        InfoSection(
          title: 'Legal and emotional support',
          body:
              'District Legal Services Authorities can provide '
              'information about legal aid. Qualified counsellors and '
              'support organisations may help with emotional support.',
          icon: Icons.volunteer_activism,
        ),
        InfoSection(
          title: 'Make a safety plan',
          body:
              'Identify a trusted person, a safer place, essential '
              'documents, and a way to seek help. Only take steps that '
              'are safe for your circumstances.',
          icon: Icons.checklist,
        ),
      ],
    );
  }
}

// ---------------- ABOUT ----------------

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'About SafeHer',
      icon: Icons.info_outline,
      subtitle: 'Awareness. Preparedness. Support.',
      sections: [
        InfoSection(
          title: 'Our mission',
          body:
              'SafeHer is an educational resource app designed to '
              'make general women’s safety information easier to find.',
          icon: Icons.favorite,
        ),
        InfoSection(
          title: 'Key features',
          body:
              'Named-route navigation, a drawer menu, trusted contacts '
              'saved on the device, emergency guidance, practical safety '
              'tips, and support resources.',
          icon: Icons.apps,
        ),
        InfoSection(
          title: 'Important limitation',
          body:
              'SafeHer is a student demonstration project. It does '
              'not automatically contact police, track location, or send '
              'SOS alerts. The SOS button is a demo only. Information '
              'is general and is not legal or professional advice.',
          icon: Icons.info,
        ),
      ],
    );
  }
}

// ---------------- REUSABLE INFORMATION PAGES ----------------

class InfoSection {
  final String title;
  final String body;
  final IconData icon;

  const InfoSection({
    required this.title,
    required this.body,
    required this.icon,
  });
}

class InfoPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final List<InfoSection> sections;

  const InfoPage({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const SafeHerDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Icon(icon, color: purple, size: 64),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 16),
          ...sections.map(
            (section) => Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(section.icon, color: purple, size: 28),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            section.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      section.body,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
