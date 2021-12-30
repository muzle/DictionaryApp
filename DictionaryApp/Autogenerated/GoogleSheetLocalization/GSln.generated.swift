// GoogleSheet: https://docs.google.com/spreadsheets/d/1gFzZZ6bueDUveyNITtTRfuZnrP2K6b6z8XcywR2L1ns/edit#gid=0
// Generated using GoogleSheetLocalizationExport: https://github.com/muzle/GoogleSheetLocalizationExport

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum GSln {
	internal enum WelcomeScene {
		/// Привет
		internal static let navigationTitle = GSln.tr("Localizable", "WelcomeScene.navigationTitle")
		/// Привет, это приложение в качестве тестового задания написал Женька
		internal static let message = GSln.tr("Localizable", "WelcomeScene.message")
		/// Отправить ему Email
		internal static let emailButton = GSln.tr("Localizable", "WelcomeScene.emailButton")
		/// Написать в Telegram
		internal static let telegramButton = GSln.tr("Localizable", "WelcomeScene.telegramButton")
		/// Поиск новых слов
		internal static let activeSearchTitle = GSln.tr("Localizable", "WelcomeScene.activeSearchTitle")
		/// Поиск слов
		internal static let inactiveSearchTitle = GSln.tr("Localizable", "WelcomeScene.inactiveSearchTitle")
	}
	internal enum Alert {
		/// Ошибка
		internal static let error = GSln.tr("Localizable", "Alert.error")
		/// Хорошо
		internal static let ok = GSln.tr("Localizable", "Alert.ok")
		/// Отмена
		internal static let cancel = GSln.tr("Localizable", "Alert.cancel")
	}
	internal enum SocialServiceError {
		/// Не удалось открыть %0@. Проверите, установлено ли приложение.
		internal static func cantOpenApp(_ p0: Any) -> String {
			return GSln.tr("GSln", "SocialServiceError.cantOpenApp", String(describing: p0))
		}
	}
	internal enum WordMeaningScene {
		/// Другой перевод
		internal static let anotherTranslation = GSln.tr("Localizable", "WordMeaningScene.anotherTranslation")
	}
	internal enum InfoView {
		/// Упс, ошибка
		internal static let errorHeader = GSln.tr("Localizable", "InfoView.errorHeader")
		/// Попробовать ещё раз
		internal static let buttonRepeat = GSln.tr("Localizable", "InfoView.buttonRepeat")
		/// Упс, такого слова не найдено
		internal static let wordNotFined = GSln.tr("Localizable", "InfoView.wordNotFined")
		/// Введите нужное слово
		internal static let needInputWord = GSln.tr("Localizable", "InfoView.needInputWord")
	}
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension GSln {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
