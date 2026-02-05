// Country selection step widget
// Second step in onboarding flow

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/onboarding/data/models/country_data.dart';

/// Country selection step
///
/// Shows a single list tile with the selected country
/// Tapping opens a full-screen searchable country picker
class CountrySelectionStep extends StatelessWidget {
  const CountrySelectionStep({
    super.key,
    required this.selectedCountryCode,
    required this.onCountrySelected,
    required this.onNextPressed,
    required this.canProceed,
  });

  final String? selectedCountryCode;
  final ValueChanged<String> onCountrySelected;
  final VoidCallback onNextPressed;
  final bool canProceed;

  @override
  Widget build(BuildContext context) {
    final selectedCountry = selectedCountryCode != null
        ? CountryData.getByCode(selectedCountryCode!)
        : null;

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  
                  // Title
                  Text(
                    'What is your country or region?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Subtitle
                  Text(
                    "This helps us find you more relevant content. We won't show it on your profile.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Country selector
                  _CountryTile(
                    country: selectedCountry,
                    onTap: () => _openCountryPicker(context),
                  ),
                ],
              ),
            ),
          ),
          
          // Next button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: canProceed ? onNextPressed : null,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFE60023),
                  disabledBackgroundColor: const Color(0xFFE8E4DE),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCountryPicker(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => _CountryPickerScreen(
          selectedCountryCode: selectedCountryCode,
          onCountrySelected: (code) {
            onCountrySelected(code);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.country,
    required this.onTap,
  });

  final Country? country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                country?.name ?? 'Select your country',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: country != null ? Colors.white : Colors.grey,
                ),
              ),
            ),
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryPickerScreen extends StatefulWidget {
  const _CountryPickerScreen({
    required this.selectedCountryCode,
    required this.onCountrySelected,
  });

  final String? selectedCountryCode;
  final ValueChanged<String> onCountrySelected;

  @override
  State<_CountryPickerScreen> createState() => _CountryPickerScreenState();
}

class _CountryPickerScreenState extends State<_CountryPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _filteredCountries = CountryData.countries;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = CountryData.countries;
      } else {
        _filteredCountries = CountryData.search(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.white, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Select country',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search countries',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(14),
                  child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 16, color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          
          // Country list
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = country.code == widget.selectedCountryCode;
                
                return ListTile(
                  tileColor: Colors.black,
                  title: Text(
                    country.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  trailing: isSelected
                      ? const FaIcon(FontAwesomeIcons.check, color: Color(0xFFE60023), size: 16)
                      : null,
                  onTap: () => widget.onCountrySelected(country.code),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
