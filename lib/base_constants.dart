
/// 组件之间是有关联性的，如Material组件很多要求要有Material Widget祖先，
/// 单组件设置forceUseMaterial或forceUseCupertino可能会发生无法预料的错误
/// 如需更改模式，建议直接在app级别上修改整个app的模式（设置targetPlatform参数）
/// 
/// 如何使用
/// cupertino: {
///   'forceUseMaterial': true
/// }
/// 强制使用material组件，在参数cupertino中使用，慎用，后续可能会删除
const String forceUseMaterial = 'forceUseMaterial';

/// material: {
///   'forceUseCupertino': true
/// }
/// 强制使用cupertino组件，在参数material中使用，慎用，后续可能会删除
const String forceUseCupertino = 'forceUseCupertino';

/// 如何使用
/// cupertino: {
///   'disabled': true
/// }
/// 
/// material: {
///   'disabled': true
/// }
/// 某个模式下禁止
const String disabled = 'disabled';
