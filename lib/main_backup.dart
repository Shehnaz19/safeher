import 'package:flutter/material.dart';

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
          drawerItem(context, Icons.home, 'Home', '/'),
          drawerItem(
            context,
            Icons.contact_phone,
            'Emergency Contacts',
            '/contacts',
          ),
          drawerItem(context, Icons.health_and_safety, 'Safety Tips', '/tips'),
          drawerItem(context, Icons.support_agent, 'Resources', '/resources'),
          drawerItem(context, Icons.info_outline, 'About SafeHer', '/about'),
        ],
      ),
    );
  }

  Widget drawerItem(
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            'Information, guidance and resources to help you make safer choices.',
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
                    'If you are in immediate danger in India, call 112 '
                    'when it is safe to do so.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Demo only: no call or alert was sent. '
                            'Use your phone to contact emergency services.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shield),
                    label: const Text('SOS Demo'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
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
          quickLink(
            context,
            Icons.contact_phone,
            'Emergency Contacts',
            '/contacts',
          ),
          quickLink(context, Icons.health_and_safety, 'Safety Tips', '/tips'),
          quickLink(
            context,
            Icons.support_agent,
            'Support Resources',
            '/resources',
          ),
          quickLink(context, Icons.info_outline, 'About SafeHer', '/about'),
        ],
      ),
    );
  }

  Widget quickLink(
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

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'Emergency Contacts',
      icon: Icons.contact_phone,
      subtitle: 'Keep important contacts accessible.',
      sections: [
        InfoSection(
          title: 'Emergency response in India',
          body:
              'Call 112 for emergency assistance when it is safe. '
              'Provide your location and explain what help you need.',
          icon: Icons.emergency,
        ),
        InfoSection(
          title: 'Women Helpline',
          body:
              '181 is a women’s helpline number in many Indian states. '
              'Availability and services may vary by location.',
          icon: Icons.support_agent,
        ),
        InfoSection(
          title: 'Trusted contacts',
          body:
              'Save a trusted friend or family member in your phone. '
              'Agree on a check-in time and a code word for emergencies.',
          icon: Icons.people,
        ),
        InfoSection(
          title: 'Safety reminder',
          body:
              'Verify local services and numbers. This app does not '
              'place calls or notify your contacts.',
          icon: Icons.info_outline,
        ),
      ],
    );
  }
}

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
              'Named-route navigation, a drawer menu, emergency '
              'guidance, practical safety tips, and support resources.',
          icon: Icons.apps,
        ),
        InfoSection(
          title: 'Important limitation',
          body:
              'SafeHer is a student demonstration project. It does '
              'not automatically contact police, track location, send '
              'SOS alerts, or guarantee personal safety. Information '
              'is general and is not legal or professional advice.',
          icon: Icons.info,
        ),
      ],
    );
  }
}

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
