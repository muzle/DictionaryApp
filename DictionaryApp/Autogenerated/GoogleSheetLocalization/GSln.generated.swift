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
		internal static let navigationTitle = GSln.tr("GSln", "WelcomeScene.navigationTitle")
		/// Привет, это приложение в качестве тестового задания написал Женька
		internal static let message = GSln.tr("GSln", "WelcomeScene.message")
		/// Отправить ему Email
		internal static let emailButton = GSln.tr("GSln", "WelcomeScene.emailButton")
		/// Написать в Telegram
		internal static let telegramButton = GSln.tr("GSln", "WelcomeScene.telegramButton")
		/// Поиск новых слов
		internal static let activeSearchTitle = GSln.tr("GSln", "WelcomeScene.activeSearchTitle")
		/// Поиск слов
		internal static let inactiveSearchTitle = GSln.tr("GSln", "WelcomeScene.inactiveSearchTitle")
	}
	internal enum Alert {
		/// Ошибка
		internal static let error = GSln.tr("GSln", "Alert.error")
		/// Хорошо
		internal static let ok = GSln.tr("GSln", "Alert.ok")
		/// Отмена
		internal static let cancel = GSln.tr("GSln", "Alert.cancel")
	}
	internal enum SocialServiceError {
		/// Не удалось открыть %0@. Проверите, установлено ли приложение.
		internal static func cantOpenApp(_ p0: Any) -> String {
			return GSln.tr("GSln", "SocialServiceError.cantOpenApp", String(describing: p0))
		}
	}
	internal enum WordMeaningScene {
		/// Другой перевод
		internal static let anotherTranslation = GSln.tr("GSln", "WordMeaningScene.anotherTranslation")
	}
	internal enum InfoView {
		/// Упс, ошибка
		internal static let errorHeader = GSln.tr("GSln", "InfoView.errorHeader")
		/// Попробовать ещё раз
		internal static let buttonRepeat = GSln.tr("GSln", "InfoView.buttonRepeat")
		/// Упс, такого слова не найдено
		internal static let wordNotFined = GSln.tr("GSln", "InfoView.wordNotFined")
		/// Введите нужное слово
		internal static let needInputWord = GSln.tr("GSln", "InfoView.needInputWord")
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
