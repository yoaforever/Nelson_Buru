angular.module('mainControllers', [])

        .controller('AppController', ['$scope', 'Session', 'Permissions', function ($scope, Session) {
                $scope.main = {
                    brand: "PayAnyBiz",
                    name: Session.name()
                },
                $scope.admin = {
                    layout: "wide",
                    menu: "vertical",
                    fixedHeader: !0,
                    fixedSidebar: !1
                },
                $scope.$watch("admin",
                        function (newVal, oldVal) {
                            return "horizontal" === newVal.menu && "vertical" === oldVal.menu ?
                                    void $rootScope.$broadcast("nav:reset") : newVal.fixedHeader === !1 &&
                                    newVal.fixedSidebar === !0 ?
                                    (oldVal.fixedHeader === !1 &&
                                            oldVal.fixedSidebar === !1 &&
                                            ($scope.admin.fixedHeader = !0, $scope.admin.fixedSidebar = !0),
                                            void (oldVal.fixedHeader === !0 &&
                                                    oldVal.fixedSidebar === !0 && ($scope.admin.fixedHeader = !1,
                                                            $scope.admin.fixedSidebar = !1))) : (newVal.fixedSidebar === !0 && ($scope.admin.fixedHeader = !0),
                                    void (newVal.fixedHeader === !1 && ($scope.admin.fixedSidebar = !1)))
                        }, !0),
                        $scope.color = {
                            primary: "#1BB7A0",
                            success: "#94B758",
                            info: "#56BDF1",
                            infoAlt: "#7F6EC7",
                            warning: "#F3C536",
                            danger: "#FA7B58"
                        };


                 $scope.role_id = Session.role_id();
                $scope.$watch('role_id', function () {

                    if ($scope.role_id == 2) {
                        $scope.nav1 = "base role";
                    }
                    if ($scope.role_id == 3) {
                        $scope.nav2 = "user role";
                    }
                    if ($scope.role_id == 5) {
                        $scope.nav = "admin";
                    }
                    if ($scope.role_id == 6) {
                        $scope.nav3 = "biller role";
                    }
                    if ($scope.role_id == 7) {
                        $scope.nav4 = "payor role";
                    }
                else
                    if ($scope.role_id == 8) {
                        $scope.customer_service = "customer service";
                    }
                });

            }])

        .controller("HeaderCtrl", ["$scope", function ($scope) {
                return $scope.introOptions = {
                    steps: [{
                            element: "#step1", intro: "<strong>Heads up!</strong> You can change the layout here", position: "bottom"
                        }, {
                            element: "#step2", intro: "Select a different language", position: "right"
                        }, {
                            element: "#step3", intro: "Runnable task App", position: "left"
                        }, {
                            element: "#step4", intro: "Collapsed nav for both horizontal nav and vertical nav", position: "right"
                        }]
                }
            }])


        .controller("NavContainerCtrl", ["$scope", function () {
            }])
        .controller('SignalRAngularCtrl', ['$scope', 'signalRSvc', '$rootScope', function ($scope, signalRSvc) {
                $scope.text = "";

                $scope.greetAll = function () {
                    signalRSvc.sendRequest();
                }

                var updateGreetingMessage = function (text) {
                    $scope.text = text;
                }

                // signalRSvc.initialize(updateGreetingMessage, null);


            }])


        .factory("localize", ["$http", "$rootScope", "$window",
            function ($http, $rootScope, $window) {
                var localize;
                return localize = {
                    language: "",
                    url: void 0,
                    resourceFileLoaded: !1,
                    successCallback:
                            function (data) {
                                return localize.dictionary = data,
                                        localize.resourceFileLoaded = !0,
                                        $rootScope.$broadcast("localizeResourcesUpdated")
                            },
                    setLanguage: function (value) {
                        return localize.language = value.toLowerCase().split("-")[0],
                                localize.initLocalizedResources()
                    },
                    setUrl: function (value) {
                        return localize.url = value,
                                localize.initLocalizedResources()
                    },
                    buildUrl: function () {
                        return localize.language || (localize.language = ($window.navigator.userLanguage || $window.navigator.language).toLowerCase(),
                                localize.language = localize.language.split("-")[0]),
                                "i18n/resources-locale_" + localize.language + ".js"
                    },
                    initLocalizedResources: function () {
                        var url;
                        return url = localize.url || localize.buildUrl(),
                                $http({method: "GET", url: url, cache: !1}).success(localize.successCallback).error(function () {
                            return $rootScope.$broadcast("localizeResourcesUpdated")
                        })
                    },
                    getLocalizedString: function (value) {
                        var result, valueLowerCase;
                        return result = void 0, localize.dictionary && value ? (valueLowerCase = value.toLowerCase(), result = "" === localize.dictionary[valueLowerCase] ? value : localize.dictionary[valueLowerCase]) : result = value, result
                    }
                }
            }])

        .directive("i18n",
                ["localize",
                    function (localize) {
                        var i18nDirective;
                        return i18nDirective = {
                            restrict: "EA",
                            updateText: function (ele, input, placeholder) {
                                var result;
                                return result = void 0,
                                        "i18n-placeholder" === input ? (result = localize.getLocalizedString(placeholder), ele.attr("placeholder", result)) : input.length >= 1 ? (result = localize.getLocalizedString(input), ele.text(result)) : void 0
                            },
                            link: function (scope, ele, attrs) {
                                return scope.$on("localizeResourcesUpdated",
                                        function () {
                                            return i18nDirective.updateText(ele, attrs.i18n, attrs.placeholder)
                                        }),
                                        attrs.$observe("i18n", function (value) {
                                            return i18nDirective.updateText(ele, value, attrs.placeholder)
                                        })
                            }
                        }
                    }])

        .controller("LangCtrl", ["$scope", "localize", function ($scope, localize) {
                return $scope.lang = "English",
                        $scope.setLang = function (lang) {
                            switch (lang) {
                                case "English":
                                    localize.setLanguage("EN-US");
                                    break;
                                case "Español":
                                    localize.setLanguage("ES-ES");
                                    break;
                                case "日本語":
                                    localize.setLanguage("JA-JP");
                                    break;
                                case "中文":
                                    localize.setLanguage("ZH-TW");
                                    break;
                                case "Deutsch":
                                    localize.setLanguage("DE-DE");
                                    break;
                                case "français":
                                    localize.setLanguage("FR-FR");
                                    break;
                                case "Italiano":
                                    localize.setLanguage("IT-IT");
                                    break;
                                case "Portugal":
                                    localize.setLanguage("PT-BR");
                                    break;
                                case "Русский язык":
                                    localize.setLanguage("RU-RU");
                                    break;
                                case "한국어":
                                    localize.setLanguage("KO-KR")
                            }
                            return $scope.lang = lang
                        },
                        $scope.getFlag = function () {
                            var lang;
                            switch (lang = $scope.lang) {
                                case "English":
                                    return "flags-american";
                                case "Español":
                                    return "flags-spain";
                                case "日本語":
                                    return "flags-japan";
                                case "中文":
                                    return "flags-china";
                                case "Deutsch":
                                    return "flags-germany";
                                case "français":
                                    return "flags-france";
                                case "Italiano":
                                    return "flags-italy";
                                case "Portugal":
                                    return "flags-portugal";
                                case "Русский язык":
                                    return "flags-russia";
                                case "한국어":
                                    return "flags-korea"
                            }
                        }
            }])


        .controller("NavCtrl", ["$scope", "filterFilter", function ($scope, filterFilter) {
//         var tasks;      
//
//
//         return tasks =   tasksService.getTasks().then(function (data) {
//             $scope.tasks = data;
//             $scope.taskRemainingCount = filterFilter(vm.tasks, { completed: !1 }).length;
//             }),      
//             $scope.$on("taskRemaining:changed",         
//             function (event, count) {
//                 return $scope.taskRemainingCount = count;
//             })
            }]);