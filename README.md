# FinCalc - Financial Calculator App

A comprehensive, modern financial calculator application built with Flutter. Featuring a clean, minimal UI and professional functionality for various financial calculations.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Platform](https://img.shields.io/badge/platform-Flutter-green)
![License](https://img.shields.io/badge/license-MIT-red)

## 🎯 Features

### Core Calculators

#### 1. **Basic Calculator**
- Addition, subtraction, multiplication, division
- Percentage calculation
- Square and square root functions
- Memory functions (M+, M-, MR, MC)
- Decimal support
- Error handling for invalid operations

#### 2. **Interest Calculators**
- **Simple Interest**: Calculate without compounding
- **Compound Interest**: With multiple compounding periods
  - Daily
  - Monthly
  - Quarterly
  - Yearly
- Shows total amount and interest earned separately

#### 3. **EMI Calculator**
- Loan amount input
- Interest rate configuration
- Loan tenure (in months)
- Displays:
  - Monthly EMI amount
  - Total interest payable
  - Total payment amount
  - Amortization schedule (first 12 months)

#### 4. **Financial Tools**
- **GST Calculator**: Calculate GST and final price
- **Discount Calculator**: Calculate discount amount and final price
- **Currency Converter**: Convert between INR, USD, EUR, GBP (static rates)
- **Savings Goal Calculator**: Calculate time to reach savings target
- **Inflation Adjuster**: Calculate future value with inflation
- **Profit & Loss Calculator**: Calculate profit/loss and margin percentage
- **Break-even Calculator**: Find break-even point for business

## 🎨 UI/UX Features

- **Modern Design**: Clean, minimal, and professional interface
- **Soft Color Palette**: 
  - Primary Blue (#2E86AB)
  - Secondary Purple (#A23B72)
  - Success Green (#18A558)
  - Warning Orange (#F18F01)
  - Error Red (#C1121F)
- **Dark Mode Support**: Toggle between light and dark themes
- **Responsive Layout**: Optimized for mobile and tablet screens
- **Smooth Animations**: Transition effects and button animations
- **Large, Readable Fonts**: Easy-to-read typography
- **Intuitive Navigation**: Tab-based interface for different calculators

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── calculation_history.dart       # History model
│   └── calculator_result.dart         # Result wrapper
├── services/
│   ├── calculator_service.dart        # Basic calculator logic
│   ├── interest_calculator_service.dart
│   ├── emi_calculator_service.dart
│   └── financial_calculator_service.dart
├── providers/
│   ├── theme_provider.dart            # Theme state management
│   └── calculator_provider.dart       # Calculator state management
├── screens/
│   ├── home_screen.dart               # Home screen
│   ├── basic_calculator_screen.dart
│   ├── interest_calculator_screen.dart
│   ├── emi_calculator_screen.dart
│   └── financial_calculators_screen.dart
├── widgets/
│   ├── custom_input_field.dart        # Reusable input component
│   ├── result_card.dart               # Result display component
│   ├── calculator_button.dart         # Calculator button component
│   ├── dropdown_field.dart            # Dropdown component
│   └── section_header.dart            # Header component
├── themes/
│   └── app_theme.dart                 # Theme definitions
└── utils/
    ├── constants.dart                 # App constants
    ├── validators.dart                # Input validators
    └── number_formatter.dart          # Number formatting utilities
```

## 🔧 Technical Stack

| Component | Technology |
|-----------|-----------|
| Framework | Flutter 3.0+ |
| Language | Dart |
| State Management | GetX |
| Local Storage | SharedPreferences |
| Number Formatting | intl |
| PDF Export | pdf package |
| Share | share_plus |
| Charts | syncfusion_flutter_charts |

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone or navigate to project**
   ```bash
   cd flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Building

**For Android:**
```bash
flutter build apk --release
```

**For iOS:**
```bash
flutter build ios --release
```

**For Web:**
```bash
flutter build web --release
```

## 📱 App Screens

### Home Screen
- Quick access to all calculators
- Welcome message
- Features overview
- Theme toggle

### Basic Calculator
- Full calculator grid with buttons
- Memory display
- Scientific functions (√, x²)
- Clear and backspace functions

### Interest Calculator
- Tabbed interface for Simple/Compound Interest
- Input fields for Principal, Rate, Time
- Compounding period selection (for CI)
- Result cards showing calculations

### EMI Calculator
- Loan amount, interest rate, tenure inputs
- Detailed EMI breakdown
- Amortization schedule (first 12 months)
- Total payment summary

### Financial Tools
- 7 different financial calculators in tabs
- GST and Discount calculators
- Currency converter
- Business financial tools (P&L, Break-even)

## 🎓 Formulas Used

### Simple Interest
```
SI = (P × R × T) / 100
Total Amount = P + SI
```

### Compound Interest
```
A = P(1 + r/n)^(nt)
CI = A - P
```
Where: n = compounding periods per year, t = time in years

### EMI
```
EMI = [P × r × (1+r)^n] / [(1+r)^n - 1]
```
Where: P = Principal, r = monthly rate, n = number of months

### GST
```
GST Amount = (Base Price × GST Rate) / 100
Final Price = Base Price + GST Amount
```

### Break-even
```
Break-even Units = Fixed Costs / (Price per Unit - Cost per Unit)
```

## 🛠️ Customization

### Adding New Calculator

1. Create a new service file in `lib/services/`:
   ```dart
   class NewCalculatorService {
     CalculatorResult<Map<String, double>> calculateSomething(...) {
       // Implementation
     }
   }
   ```

2. Create a new screen in `lib/screens/`:
   ```dart
   class NewCalculatorScreen extends StatefulWidget {
     // Implementation
   }
   ```

3. Add route to home screen navigation

### Changing Color Palette

Edit `lib/utils/constants.dart`:
```dart
static const int primaryColor = 0xFF2E86AB;
static const int secondaryColor = 0xFFA23B72;
// ... etc
```

### Adding Dark Mode Colors

Update `AppTheme.darkTheme()` in `lib/themes/app_theme.dart`

## 🔒 Input Validation

The app includes comprehensive input validation:
- Positive number validation
- Zero division prevention
- Range validation
- Error messages for invalid inputs
- Try-catch error handling in all calculations

## 📊 State Management

Uses **GetX** for:
- Theme management
- Calculator state
- Result caching
- Navigation

## 💡 Best Practices Implemented

✅ **Clean Code**
- Separated business logic from UI
- Reusable components
- Clear naming conventions
- Comprehensive comments

✅ **Error Handling**
- Try-catch blocks in calculations
- User-friendly error messages
- Validation before calculation
- Graceful error recovery

✅ **Performance**
- Efficient state management
- No unnecessary rebuilds
- Optimized calculations
- Responsive UI

✅ **Scalability**
- Modular architecture
- Easy to add new calculators
- Reusable service structure
- Extensible design

## 🔮 Future Enhancements

- [ ] Calculation history with local database
- [ ] Export results as PDF
- [ ] Share functionality
- [ ] Multi-language support
- [ ] Real-time currency rates via API
- [ ] Investment portfolio calculator
- [ ] Retirement planning calculator
- [ ] Tax calculator with brackets
- [ ] Budget planner
- [ ] Expense tracker

## 📝 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👨‍💻 Author

Created with ❤️ for financial calculation enthusiasts.

## 📧 Support

For issues, questions, or suggestions, please create an issue in the repository.

---

**FinCalc** - Making financial calculations simple, accurate, and accessible.
