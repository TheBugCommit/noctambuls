// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Noctámbulos';

  @override
  String get errorUnknown => 'Se ha producido un error desconocido.';

  @override
  String get back => 'Volver';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get retry => 'Volver a intentar';

  @override
  String get ignore => 'Ignorar';

  @override
  String get confirmDelete => 'Sí, eliminar';

  @override
  String get homeLabel => 'Inicio';

  @override
  String get guideLabel => 'Guía';

  @override
  String get exploreLabel => 'Explora';

  @override
  String get profileLabel => 'Perfil';

  @override
  String get loginTitle => 'Bienvenido/a';

  @override
  String get loginSubtitle => 'Inicia sesión para continuar';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get signInError => 'No se pudo iniciar sesión. Inténtalo de nuevo.';

  @override
  String get signOutLabel => 'Cerrar sesión';

  @override
  String get signUpTitle => 'Completa tu perfil';

  @override
  String get signUpSessionExpired =>
      'La sesión ha caducado, por favor, vuelve a iniciar sesión';

  @override
  String get signUpError => 'Se ha producido un error. Vuelve a intentarlo.';

  @override
  String get signUpHeaderTitle => '¡Ya casi estamos!';

  @override
  String get signUpHeaderSubTitle =>
      'Necesitamos algunos datos básicos para finalizar tu registro.';

  @override
  String get signUpFormNameLabel => 'Nombre completo';

  @override
  String get signUpFormNameLength =>
      'El nombre debe tener al menos 3 caracteres';

  @override
  String get signUpFormNameMaxLength =>
      'El nombre no debe superar los 40 caracteres';

  @override
  String get signUpFormFieldRequired => 'Este campo es obligatorio';

  @override
  String get signUpFormPhoneLabel => 'Teléfono';

  @override
  String get signUpFormPhoneFormat => 'Introduce un teléfono válido';

  @override
  String get signUpSendButton => 'Finalizar registro';

  @override
  String get signUpSendButtonLoading => 'Registrando...';

  @override
  String get accept_terms_prefix => 'He leído y acepto los ';

  @override
  String get terms_and_conditions => 'Términos y Condiciones';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsPreferencesTitle => 'Preferencias';

  @override
  String get settingsAccountTitle => 'Cuenta';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get catalanLabel => 'Catalán';

  @override
  String get spanishLabel => 'Castellano';

  @override
  String get themeLabel => 'Tema visual';

  @override
  String get themeLightLabel => 'Claro';

  @override
  String get themeDarkLabel => 'Oscuro';

  @override
  String get themeSystemLabel => 'Sistema';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get censusLabel => 'Censo';

  @override
  String get stationLabel => 'Estación de seguimiento';

  @override
  String get incidentalLabel => 'Observación puntual';

  @override
  String get observingMethodTitle => 'Sobre los métodos de observación';

  @override
  String get observingMethodConfirmLabel => 'Entendido';

  @override
  String get observingMethodCensTitle => 'Censo';

  @override
  String get observingMethodCensDescription =>
      'Participa en un censo simultáneo organizado. Utiliza esta opción cuando participes en una jornada o campaña de censo coordinada y quieras registrar las observaciones de tu punto.';

  @override
  String get observingMethodESTitle => 'Estación de seguimiento';

  @override
  String get observingMethodESDescription =>
      'Registra las observaciones de tu estación de seguimiento. Utiliza esta opción si tienes asignada una estación de seguimiento y realizas muestreos periódicos en ella.';

  @override
  String get observingMethodIncTitle => 'Observación puntual';

  @override
  String get observingMethodIncDescription =>
      'Comunica una observación ocasional. Utiliza esta opción si escuchas u observas un ave nocturna fuera de un censo o de una estación de seguimiento y nos lo quieres comunicar.';

  @override
  String get activeSessionTitle => 'Sesión en curso';

  @override
  String get startedAt => 'Observando desde las ';

  @override
  String get errorSessionAlreadyExists =>
      'Ya hay una sesión activa. Finalízala o cancélala primero.';

  @override
  String observationsRegistered(int count) {
    return '$count observaciones registradas';
  }

  @override
  String get noObservationsRegistered =>
      'No hay ninguna observación registrada';

  @override
  String get observingTitle => 'Observando';

  @override
  String get stopAndReview => 'Detener';

  @override
  String get continueObserving => 'Continuar observando';

  @override
  String get stopSessionTitle => '¿Detener la sesión?';

  @override
  String get stopSessionBody =>
      'Las observaciones ya registradas se conservarán.';

  @override
  String get stopSessionConfirm => 'Detener';

  @override
  String get reviewTitle => 'Revisión';

  @override
  String get sessionInReview => 'Sesión en revisión';

  @override
  String get continueReview => 'Continuar la revisión';

  @override
  String get deleteSession => 'Cancelar sesión';

  @override
  String get deleteSessionTitle => '¿Cancelar sesión?';

  @override
  String get deleteSessionBody =>
      'Se perderá toda la información y no se podrá recuperar.';

  @override
  String get confirmDeleteSessionTitle => '¿Quieres eliminar la sesión?';

  @override
  String get confirmDeleteSessionMessage =>
      'Se perderán todas las observaciones de esta sesión. Esta acción es irreversible.';

  @override
  String get noBirdsFound => 'No se han encontrado aves';

  @override
  String get listen => 'Escuchar';

  @override
  String get moreInfo => 'Más info';

  @override
  String semanticLabelBirdImage(String bird) {
    return 'Fotografía de $bird';
  }

  @override
  String get noImageAvailable => 'La imagen no está disponible';

  @override
  String get downloadingCatalog => 'Descargando las aves...';

  @override
  String get connectionError => 'Error de conexión';

  @override
  String get catalogDownloadError =>
      'No se ha podido descargar el catálogo de aves. Comprueba tu conexión a internet.';

  @override
  String get requiredBirdCatalog => 'Catálogo de aves requerido';

  @override
  String get requiredBirdCatalogMsg =>
      'Para usar esta sección necesitas descargar el catálogo de aves al menos una vez.';

  @override
  String get downloadNow => 'Descargar ahora';

  @override
  String get homeErrorDownloadCatalog =>
      'Descarga del catálogo de aves fallida';

  @override
  String get homeErrorDownloadCatalogMsg =>
      'No se ha podido descargar el catálogo de aves. Puedes seguir usando la aplicación o volver a intentar la descarga.';

  @override
  String get usageWarningTitle => 'Uso responsable de los cantos';

  @override
  String get usageWarningMessage =>
      'Los cantos son solo una herramienta de consulta puntual para ayudar a confirmar la identificación en caso de duda.\n\nNo los reproduzcas de manera repetida ni innecesaria en el campo, ya que pueden alterar el comportamiento de las aves y distorsionar los resultados de los seguimientos.';

  @override
  String get usageWarningConfirm => 'Sí, lo entiendo';

  @override
  String get cantOpenLink => 'No se ha podido abrir el enlace';

  @override
  String get cantPlayAudio => 'No se ha podido reproducir el audio';

  @override
  String get stopPlayingAudio => 'Detener';

  @override
  String get profileOrnithologistCode => 'Código de ornitólogo';

  @override
  String get profileShowQr => 'Mostrar QR';

  @override
  String get profileQrDialogTitle => 'Código QR de ornitólogo';

  @override
  String get profileQrDialogClose => 'Cerrar';

  @override
  String get profileObservationsTab => 'Observaciones';

  @override
  String get profileParticipationsTab => 'Participaciones';

  @override
  String get profileEditTitle => 'Editar perfil';

  @override
  String get profileEditSaveButton => 'Guardar cambios';

  @override
  String get profileEditSaveButtonLoading => 'Guardando...';

  @override
  String get profileEditSuccess => 'Perfil actualizado correctamente';

  @override
  String get profileEditError => 'No se pudo actualizar el perfil';

  @override
  String get profileLoadError => 'No se pudo cargar el perfil';

  @override
  String get profileObservationsEmpty => 'Aún no hay observaciones.';

  @override
  String get profileRetry => 'Volver a intentar';

  @override
  String get profileSignOut => 'Cerrar sesión';

  @override
  String get settingsSupportTitle => 'Soporte';

  @override
  String get settingsHelp => 'Ayuda';

  @override
  String get settingsAbout => 'Acerca de Noctámbulos';

  @override
  String get settingsTellAFriend => 'Díselo a un amigo';

  @override
  String get settingsTellAFriendText =>
      '¡Descubre Noctámbulos, la app para registrar tus observaciones de aves! 🦉';

  @override
  String get settingsLegalTitle => 'Legal';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTermsOfUse => 'Términos de uso';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get notificationChannelSyncName => 'Sincronización';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteAccountDialogTitle => '¿Eliminar cuenta?';

  @override
  String get settingsDeleteAccountDialogBody =>
      'Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.';

  @override
  String get settingsDeleteAccountDialogConfirm => 'Sí, eliminar';

  @override
  String get settingsDeleteAccountError =>
      'No se pudo eliminar la cuenta. Inténtalo de nuevo.';

  @override
  String get newObservationTitle => 'Nueva Observación';

  @override
  String get editObservationTitle => 'Editar Observación';

  @override
  String get saveObservation => 'Guardar';

  @override
  String get selectSpecies => 'Especie';

  @override
  String get timeRangeLabel => 'Franja horaria';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get contactTypeLabel => 'Tipo de Contacto';

  @override
  String get locationLabel => 'Ubicación';

  @override
  String get directionLabel => 'Dirección';

  @override
  String get notesLabel => 'Notas';

  @override
  String get notesHint => 'Añade notas...';

  @override
  String get notesContactHintIntro =>
      'Si tienes dudas o no puedes identificar la especie, puedes grabarla y enviarnos un audio o vídeo a:';

  @override
  String get fetchingLocation => 'Obteniendo ubicación...';

  @override
  String get locationUnavailable => 'Ubicación no disponible';

  @override
  String get compassLabel => 'Orientación';

  @override
  String get confirmDeleteObservationTitle =>
      '¿Quieres eliminar la observación?';

  @override
  String get confirmDeleteObservationMessage =>
      'Esta acción no se puede deshacer.';

  @override
  String get errorSavingObservation =>
      'Ha ocurido un error al guardar la observacion';

  @override
  String get visualContactType => 'Visual';

  @override
  String get auditiveContactType => 'Auditivo';

  @override
  String get reduceQuantityTooltip => 'Reduece la cantidad';

  @override
  String get incrementQuantityTooltip => 'Incrementa la cantidad';

  @override
  String get orientationTitle => 'Orientación';

  @override
  String get orientationHint => 'Toca para definir la orientación';

  @override
  String get compassError => 'Error leyendo los sensores.';

  @override
  String get compassNoSensor => 'El dispositivo no tiene sensor de brújula.';

  @override
  String get compassInstruction =>
      'Apunta el teléfono hacia la observación y pulsa fijar.';

  @override
  String get compassFixDirection => 'Fijar Dirección';

  @override
  String get locationDirectionTitle => 'Ubicación y Orientación';

  @override
  String get orientationRequired => 'La orientación es obligatoria';

  @override
  String get updateGPS => 'Actualizar GPS';

  @override
  String get updateOrientation => 'Modificar Orientación';

  @override
  String orientationValueLong(String orientation, String value) {
    return '$orientation $value°';
  }

  @override
  String get compassManualMode => 'Introducir manualmente';

  @override
  String get compassDegreesHint => 'Grados';

  @override
  String compassDegreesFormat(String orientation, String value) {
    return '$value° $orientation';
  }

  @override
  String get compassNoSensorFallback =>
      'No se detectó sensor. Uso manual requerido.';

  @override
  String get observationDateLabel => 'Fecha de la observación';

  @override
  String get dayLabel => 'Día';

  @override
  String get startTimeLabel => 'Hora inicio';

  @override
  String get endTimeLabel => 'Hora fin';

  @override
  String get changeDateLabel => 'Cambiar fecha';

  @override
  String obsCardQuantityLabel(int value) {
    return 'x$value';
  }

  @override
  String get statusObserving => 'En curso';

  @override
  String get statusReviewing => 'En revisión';

  @override
  String get statusDraft => 'Borrador';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusSyncing => 'Sincronizando';

  @override
  String get statusSynced => 'Sincronizado';

  @override
  String get statusSyncError => 'Error de red';

  @override
  String get syncErrorValidation => 'Error en los datos.';

  @override
  String get syncErrorNetwork => 'Sin conexión. Se reintentará más tarde.';

  @override
  String get syncErrorServer => 'Se ha producido un error en el servidor.';

  @override
  String get syncErrorUnknown => 'Error desconocido al sincronizar.';

  @override
  String get notificationSyncPendingTitle => 'Sincronización pendiente';

  @override
  String notificationSyncPendingBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Tienes $count sesiones pendientes de subir. Revísalas cuando puedas.',
      one: 'Tienes 1 sesión pendiente de subir. Revísala cuando puedas.',
    );
    return '$_temp0';
  }

  @override
  String get notificationSyncErrorTitle => 'Error de sincronización';

  @override
  String get notificationSyncErrorBody =>
      'No hemos podido conectar con el servidor para subir tus observaciones.';

  @override
  String get stopAndReviewTitle => 'Finalizar observación';

  @override
  String get stopAndReviewMessage =>
      '¿Estás seguro de que quieres detener el tiempo y pasar a revisar los datos?';

  @override
  String get stopAndReviewConfirm => 'Finalizar';

  @override
  String get sessionCardEndsAt => 'Finalitzada a las ';

  @override
  String get errorLoadingObservationSessions =>
      'Error cargando las sessiones de observación';

  @override
  String get reviewMeteoTitle => 'Meteorología';

  @override
  String get meteoTemp => 'Temperatura';

  @override
  String get meteoTempBelow0 => '< 0°C';

  @override
  String get meteoTemp0to10 => '0–10°C';

  @override
  String get meteoTemp10to20 => '10–20°C';

  @override
  String get meteoTemp20to30 => '20–30°C';

  @override
  String get meteoTempAbove30 => '> 30°C';

  @override
  String get meteoWind => 'Viento';

  @override
  String get meteoWindCalm => 'Calma';

  @override
  String get meteoWindBreeze => 'Brisa';

  @override
  String get meteoWindModerate => 'Moderado';

  @override
  String get meteoSky => 'Cielo';

  @override
  String get meteoSkyClear => 'Despejado';

  @override
  String get meteoSkyPartlyCloudy => 'Claros';

  @override
  String get meteoSkyOvercast => 'Cubierto';

  @override
  String get meteoRain => 'Lluvia';

  @override
  String get meteoRainAbsence => 'Ausencia';

  @override
  String get meteoRainDrizzle => 'Llovizna';

  @override
  String get meteoRainStorm => 'Tormenta';

  @override
  String get meteoVisibility => 'Visibilidad';

  @override
  String get meteoVisibilityPoor => 'Pésima';

  @override
  String get meteoVisibilityFair => 'Regular';

  @override
  String get meteoVisibilityGood => 'Buena';

  @override
  String get meteoMoon => 'Luna';

  @override
  String get meteoMoonAbsence => 'Ausente';

  @override
  String get meteoMoonPresence => 'Presente';

  @override
  String get listeningPointLabel => 'Punto de escucha';

  @override
  String get listeningPointHint => 'Número de punto';

  @override
  String get reviewDeleteBtn => 'Cancelar sesión';

  @override
  String get reviewFinalizeBtn => 'Finalizar';

  @override
  String get reviewAddObservationBtn => 'Añadir';

  @override
  String get reviewObservationsTitle => 'Observaciones';

  @override
  String get confirmFinalizeTitle => '¿Finalizar sesión?';

  @override
  String get confirmFinalizeMessage =>
      'Una vez finalizada, la sesión no se podrá editar.';

  @override
  String get confirmFinalizeConfirm => 'Finalizar';

  @override
  String get requiredFieldError => 'Campo obligatorio';

  @override
  String get reviewErrorSaving => 'Error guardando la revisión';

  @override
  String get reviewLocationIncidentalTitle => 'Ubicación de las observaciones';

  @override
  String get reviewLocationSessionTitle => 'Ubicación de la sesión';

  @override
  String get reviewLocationRequiredError =>
      'Es necesario establecer la ubicación de la sesión para finalizar.';

  @override
  String get reviewLocationModify => 'Modificar sesión';

  @override
  String get reviewLocationMissing => 'Sin ubicación';

  @override
  String get reviewLocationIncidentalMissingDesc =>
      'Añade ubicaciones editando cada una de las observaciones del listado inferior.';

  @override
  String get reviewLocationSessionMissingDesc =>
      'La sesión no tiene coordenadas registradas.';

  @override
  String get reviewLocationSetMap => 'Establecer en el Mapa';

  @override
  String get reviewLocationNoInternet => 'Sin conexión';

  @override
  String get reviewLocationNoInternetDesc =>
      'El mapa de previsualización requiere internet. Aún así, las coordenadas guardadas son seguras.';

  @override
  String get reviewMissingLocationsIncidental =>
      'Debes añadir la ubicación a las observaciones marcadas en rojo.';

  @override
  String get participantsTitle => 'Participantes';

  @override
  String get addParticipant => 'Añadir';

  @override
  String get noParticipantsAdded => 'No hay participantes añadidos.';

  @override
  String get participantAlreadyAdded => 'Este participante ya está añadido.';

  @override
  String get scannerTitle => 'Escanear Participante';

  @override
  String get invalidQrCode => 'Código QR no válido para esta app.';

  @override
  String get enterCodeManually => 'Introducir código manualmente';

  @override
  String get enterCodeTitle => 'Introducir Código';

  @override
  String get codeHint => '#OR-ABC-1234';

  @override
  String get emptyCodeError => 'Introduce un código.';

  @override
  String get invalidCodeFormat => 'Formato inválido. Ej: #OR-ABCD-1234';

  @override
  String get add => 'Añadir';

  @override
  String get scannerHelperText =>
      'Escanea el QR de ornitólogo del perfil del participante';

  @override
  String get scannerHelpTitle => '¿Cómo añadir un participante?';

  @override
  String get scannerHelpMessage =>
      'Pide al otro usuario que abra su perfil para mostrar su código QR y apunta con la cámara.\n\nSi la cámara no funciona o no detecta el código, puedes introducirlo manualmente pulsando el botón inferior.';

  @override
  String get understood => 'Entendido';

  @override
  String get locationErrorTooltip => 'Error de GPS';

  @override
  String get locationManualTooltip => 'Ubicación Manual';

  @override
  String get locationAutoTooltip => 'Ubicación Automática (GPS)';

  @override
  String get locationGpsOffTitle => 'Activa la ubicación del dispositivo';

  @override
  String get locationGpsOffContent =>
      'La ubicación del dispositivo está desactivada. Para poder registrar coordenadas precisas en las observaciones y sesiones, activa el GPS desde la configuración del teléfono y vuelve a intentarlo.';

  @override
  String get locationPermissionTitle => 'Permiso de ubicación necesario';

  @override
  String get locationPermissionContent =>
      'Noctámbulos necesita acceso a la ubicación para guardar la posición exacta de las observaciones de aves y de las sesiones de censo.\n\nHas denegado el permiso de forma permanente. Para continuar, abre la configuración del dispositivo y habilita el permiso de ubicación para la aplicación.';

  @override
  String get actionLater => 'Ahora no';

  @override
  String get actionOpenSettings => 'Abrir configuración';

  @override
  String get observationLocationTitle => 'Ubicación de la observación';

  @override
  String get observationAtLocationToggle =>
      'Estoy en el lugar de la observación';

  @override
  String get locationWaitingGps => 'Esperando señal GPS...';

  @override
  String get locationMapRequired => 'Falta marcar el punto en el mapa';

  @override
  String get locationModifyMap => 'Modificar en el mapa';

  @override
  String get locationOpenMap => 'Abrir el mapa';

  @override
  String get locationErrorPermission =>
      'Permisos de GPS denegados. Actívalos en ajustes o usa el mapa.';

  @override
  String get locationErrorDisabled =>
      'El GPS está apagado. Actívalo o usa el mapa.';

  @override
  String get locationErrorTimeout =>
      'Sin señal GPS. Selecciona la ubicación manualmente en el mapa.';

  @override
  String get permissionsRequired => 'Permisos necesarios';

  @override
  String get gpsDisabled => 'GPS desactivado';

  @override
  String get locationManualTitle => 'Ubicación manual';

  @override
  String get locationAutoTitle => 'Ubicación automática';

  @override
  String get mapPickerTitle => 'Seleccionar ubicación';

  @override
  String get mapPickerConfirm => 'Confirmar ubicación';

  @override
  String get mapPickerSelectPoint => 'Mantén pulsado para colocar el marcador';

  @override
  String get mapPickerHelpTitle => 'Cómo usar el mapa';

  @override
  String get mapPickerHelpContent =>
      'Mantén pulsado en cualquier punto del mapa para colocar el marcador. Puedes usar el botón de la diana para centrar el mapa en tu ubicación actual.';

  @override
  String get ok => 'De acuerdo';

  @override
  String get censusSessionExistentWarning =>
      'Ya existe una session para este censo.';

  @override
  String get censusConfirmStartTitle =>
      '¿Seguro que quieres iniciar la sesión de observación ahora?';

  @override
  String get censusConfirmStartButton => 'Sí, iniciar';

  @override
  String get censusDetailTitle => 'Detalle del censo';

  @override
  String get censusDescriptionTitle => 'Descripción';

  @override
  String get censusNoDescription =>
      'Este censo no tiene ninguna descripción añadida.';

  @override
  String get censusesUpcomingTitle => 'Próximos censos';

  @override
  String get censusesUpcomingEmpty => 'No hay próximos censos';

  @override
  String get censusLobbyWaiting => 'Censo en espera';

  @override
  String get censusEnterLobby => 'Entrar';

  @override
  String get censusAbandon => 'Cancelar';

  @override
  String get censusStartSession => 'Iniciar sesión';

  @override
  String get censusWarningPoint =>
      'Por favor, no inicies la sesión hasta que no estés en el punto de escucha y sea la hora acordada para empezar el censo.';

  @override
  String get censusDirectionLabel => 'Dirección:';

  @override
  String get censusNotTodayBody =>
      'Este censo no se celebra hoy. Comprueba la fecha e inténtalo de nuevo el día de la jornada.';

  @override
  String get censusLobbyConflictBody =>
      'Ya estás inscrito en otro censo. Cancélalo antes de unirte a un nuevo censo.';

  @override
  String get censusAlreadySessionActive =>
      'Cierra la sesión activa antes de iniciar la del censo.';

  @override
  String get censusInvalidTokenBody =>
      'El código QR o el enlace del censo no ha podido verificarse. Asegúrate de que es correcto.';

  @override
  String get censusQrScanTitle => 'Escanea el QR del censo';

  @override
  String get censusQrScanHelper => 'Apunta la cámara al código QR del censo';

  @override
  String get censusQrHelpTitle => '¿Cómo unirse al censo?';

  @override
  String get censusQrHelpBody =>
      'Escanea el código QR compartido por el coordinador o la coordinadora del censo. Si no puedes escanearlo, también puedes abrir el enlace URL que haya compartido.';

  @override
  String get exploreTitle => 'Explora';

  @override
  String get exploreAllSpecies => 'Todas las especies';

  @override
  String get exploreHistoric => 'Histórico';

  @override
  String get exploreBreakdownTitle => 'Observaciones Registradas';

  @override
  String get exploreKpiSpecies => 'Especies';

  @override
  String get exploreKpiObservations => 'Observaciones';

  @override
  String get exploreSyncing => 'Cargando datos...';

  @override
  String get exploreSyncError => 'Error al cargar los datos';

  @override
  String get exploreNoData => 'Sin datos de observación';

  @override
  String get exploreRetry => 'Reintentar';

  @override
  String get exploreNoInternet => 'Sin conexión';

  @override
  String get exploreNoInternetDesc =>
      'El mapa requiere conexión a internet para visualizarse.';

  @override
  String exploreBubbleObservations(int count) {
    return '$count observaciones';
  }

  @override
  String get exploreMapPickerHelpTitle => '¿Cómo funciona el explorador?';

  @override
  String get exploreMapPickerHelpContent =>
      'Navega por el mapa para descubrir dónde se han observado las diferentes especies. \n\n• El tamaño de las burbujas cambian según la cantidad de observaciones.\n• Toca cualquier burbuja para ver el resumen exacto.\n• Utiliza el panel inferior para filtrar los resultados por una especie concreta o por el año de observación.';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsClearAll => 'Borrar todo';

  @override
  String get notificationsEmpty => 'No tienes ninguna notificación.';

  @override
  String get notificationsClose => 'Cerrar';
}
