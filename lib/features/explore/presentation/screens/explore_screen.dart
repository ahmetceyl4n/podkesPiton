import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/genre_mapping.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/podcast_entity.dart';
import '../cubit/podcast_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PodcastCubit>()..fetchTrending(),
      child: const _ExploreScreenBody(),
    );
  }
}

class _ExploreScreenBody extends StatefulWidget {
  const _ExploreScreenBody({super.key});

  @override
  State<_ExploreScreenBody> createState() => _ExploreScreenBodyState();
}

class _ExploreScreenBodyState extends State<_ExploreScreenBody> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> categories = availableCategories;
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';
  String searchQuery = '';
  int _selectedIndex = 0;

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.push('/explore');
        break;
      case 1:
        break;
      case 2:
        context.push('/profile');
        break;
    }
  }

  void _showAnimatedCenterNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  'Şu anlık bildirim yok',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      controller.reverse().then((_) {
        entry.remove();
        controller.dispose();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0D0C1D),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        backgroundColor: const Color(0xFF1B1A2D),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/profile_placeholder.jpg'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Welcome,', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Text('Ahmet Ceylan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.explore, color: Colors.white),
                title: const Text('Discover', style: TextStyle(color: Colors.white)),
                onTap: () => context.go('/explore'),
              ),
              ListTile(
                leading: const Icon(Icons.library_music, color: Colors.white),
                title: const Text('Library', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Log out', style: TextStyle(color: Colors.redAccent)),
                onTap: () {},
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        backgroundColor: const Color(0xFF0D0C1D),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/icons/menu_icon.png', width: 24, height: 24, color: Colors.white),
                        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      ),
                      const Text('Podkes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.white),
                        onPressed: () => _showAnimatedCenterNotification(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1C2A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.white54),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(Icons.search, color: Colors.white60),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = cat == selectedCategory;

                        return ChoiceChip(
                          label: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (_) => setState(() => selectedCategory = cat),
                          selectedColor: Colors.white,
                          backgroundColor: const Color(0xFF1E1C2A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.white24),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Trending', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: BlocBuilder<PodcastCubit, PodcastState>(
                  builder: (context, state) {
                    if (state is PodcastLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PodcastLoaded) {
                      var podcasts = selectedCategory == 'All'
                          ? state.podcasts
                          : state.podcasts.where((p) => mapGenreToCategory(p.genreIds) == selectedCategory).toList();

                      if (searchQuery.isNotEmpty) {
                        podcasts = podcasts.where((p) =>
                        p.title.toLowerCase().contains(searchQuery) ||
                            p.author.toLowerCase().contains(searchQuery)).toList();
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.only(bottom: 8),
                        itemCount: podcasts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final podcast = podcasts[index];
                          return GestureDetector(
                            onTap: () => context.push('/now-playing', extra: {
                              'image': podcast.imageUrl,
                              'title': podcast.title,
                              'author': podcast.author,
                              'audioUrl': podcast.audioUrl,
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      podcast.imageUrl,
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    podcast.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    podcast.author,
                                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is PodcastError) {
                      return Center(
                        child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.white)),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}