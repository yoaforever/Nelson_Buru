﻿(function () {
    "use strict";
    angular.module("myApp.nav.directives", [])
        .directive("toggleNavCollapsedMin",
        ["$rootScope",
            function ($rootScope) {
                return {
                    restrict: "A",
                    link: function (scope, ele) {
                        var myApp;
                        return myApp = $("#myApp"),
                            ele.on("click", function (e) {
                                return myApp.hasClass("nav-collapsed-min") ? myApp.removeClass("nav-collapsed-min") : (myApp.addClass("nav-collapsed-min"),
                                    $rootScope.$broadcast("nav:reset")),
                                    e.preventDefault()
                            })
                    }
                }
            }])
        .directive("collapseNav",
        [function () {
            return {
                restrict: "A",
                link: function (scope, ele) {
                    var $a, $aRest, $myApp, $lists, $listsRest, $nav, $window, Timer, prevWidth, updateClass;
                    return $window = $(window),
                        $lists = ele.find("ul").parent("li"),
                        $lists.myAppend('<i class="fa fa-caret-down icon-has-ul-h"></i><i class="fa fa-caret-right icon-has-ul"></i>'),
                        $a = $lists.children("a"),
                        $listsRest = ele.children("li").not($lists),
                        $aRest = $listsRest.children("a"),
                        $myApp = $("#myApp")
                        , $nav = $("#nav-container"),
                        $a.on("click", function (event) {
                            var $parent, $this;
                            return $myApp.hasClass("nav-collapsed-min") || $nav.hasClass("nav-horizontal") && $window.width() >= 768 ? !1 : ($this = $(this),
                                $parent = $this.parent("li"),
                                $lists.not($parent).removeClass("open").find("ul").slideUp(),
                                $parent.toggleClass("open").find("ul").slideToggle(),
                                event.preventDefault())
                        }),
                        $aRest.on("click", function () {
                            return $lists.removeClass("open").find("ul").slideUp()
                        }),
                        scope.$on("nav:reset", function () {
                            return $lists.removeClass("open").find("ul").slideUp()
                        }),
                        Timer = void 0,
                        prevWidth = $window.width(),
                        updateClass = function () {
                            var currentWidth;
                            return currentWidth = $window.width(), 768 > currentWidth && $myApp.removeClass("nav-collapsed-min"),
                                768 > prevWidth && currentWidth >= 768 && $nav.hasClass("nav-horizontal")
                                && $lists.removeClass("open").find("ul").slideUp(),
                                prevWidth = currentWidth
                        },
                        $window.resize(function () {
                            var t;
                            return clearTimeout(t), t = setTimeout(updateClass, 300)
                        })
                }
            }
        }])
        .directive("highlightActive",
        [function () {
            return {
                restrict: "A",
                controller: ["$scope", "$element", "$attrs", "$location",
                    function ($scope, $element, $attrs, $location) {
                        var highlightActive, links, path;
                        return links = $element.find("a"),
                            path = function () {
                                return $location.path()
                            },
                            highlightActive = function (links, path) {
                                return path = "#" + path,
                                    angular.forEach(links, function (link) {
                                        var $li, $link, href;
                                        return $link = angular.element(link),
                                            $li = $link.parent("li"),
                                            href = $link.attr("href"),
                                            $li.hasClass("active") && $li.removeClass("active"), 0 === path.indexOf(href) ? $li.addClass("active") : void 0
                                    })
                            },
                            highlightActive(links, $location.path()),
                            $scope.$watch(path, function (newVal, oldVal) {
                                return newVal !== oldVal ? highlightActive(links, $location.path()) : void 0
                            })
                    }]
            }
        }])
        .directive("toggleOffCanvas",
        [function () {
            return {
                restrict: "A",
                link: function (scope, ele) {
                    return ele.on("click", function () {
                        return $("#myApp").toggleClass("on-canvas")
                    })
                }
            }
        }])
})();