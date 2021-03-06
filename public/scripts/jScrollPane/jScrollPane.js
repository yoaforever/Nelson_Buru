/*
 * jScrollPane - v2.0.0beta5 - 2010-09-18
 * http://jscrollpane.kelvinluck.com/
 *
 * Copyright (c) 2010 Kelvin Luck
 * Dual licensed under the MIT and GPL licenses.
 */
(function(b, a, c) {
    b.fn.jScrollPane = function(f) {
        function d(C, L) {
            var au, N = this,
                V, ah, v, aj, Q, W, y, q, av, aB, ap, i, H, h, j, X, R, al, U, t, A, am, ac, ak, F, l, ao, at, x, aq, aE, g, aA, ag = true,
                M = true,
                aD = false,
                k = false,
                Z = b.fn.mwheelIntent ? "mwheelIntent.jsp" : "mousewheel.jsp";
            aE = C.css("paddingTop") + " " + C.css("paddingRight") + " " + C.css("paddingBottom") + " " + C.css("paddingLeft");
            g = (parseInt(C.css("paddingLeft")) || 0) + (parseInt(C.css("paddingRight")) || 0);
            an(L);

            function an(aH) {
                var aL, aK, aJ, aG, aF, aI;
                au = aH;
                if (V == c) {
                    C.css({
                        overflow: "hidden",
                        padding: 0
                    });
                    ah = C.innerWidth() + g;
                    v = C.innerHeight();
                    C.width(ah);
                    V = b('<div class="jspPane" />').wrap(b('<div class="jspContainer" />').css({
                        width: ah + "px",
                        height: v + "px"
                    }));
                    C.wrapInner(V.parent());
                    aj = C.find(">.jspContainer");
                    V = aj.find(">.jspPane");
                    V.css("padding", aE)
                } else {
                    C.css("width", null);
                    aI = C.outerWidth() + g != ah || C.outerHeight() != v;
                    if (aI) {
                    	ah = C.innerWidth() + g;
                        v = C.innerHeight();
                        aj.css({
                            width: ah + "px",
                            height: v + "px"
                        })
                    }
                    aA = V.innerWidth();
                    if (!aI && V.outerWidth() == Q && V.outerHeight() == W) {
                        if (aB || av) {
                            //V.css("width", aA + "px");
                            //C.css("width", (aA + g) + "px")
                        	V.css("width", "500px");
                            C.css("width", "500px")
                        }
                        return
                    }
                    V.css("width", null);
                    C.css("width", (ah) + "px");
                    aj.find(">.jspVerticalBar,>.jspHorizontalBar").remove().end()
                }
                aL = V.clone().css("position", "absolute");
                aK = b('<div style="width:1px; position: relative;" />').append(aL);
                b("body").append(aK);
                Q = Math.max(V.outerWidth(), aL.outerWidth());
                aK.remove();
                W = V.outerHeight();
                y = Q / ah;
                q = W / v;
                av = q > 1;
                aB = y > 1;
                if (!(aB || av)) {
                    C.removeClass("jspScrollable");
                    V.css({
                        top: 0,
                        width: aj.width() - g
                    });
                    n();
                    D();
                    O();
                    w();
                    af()
                } else {
                    C.addClass("jspScrollable");
                    aJ = au.maintainPosition && (H || X);
                    if (aJ) {
                        aG = ay();
                        aF = aw()
                    }
                    aC();
                    z();
                    E();
                    if (aJ) {
                        K(aG);
                        J(aF)
                    }
                    I();
                    ad();
                    if (au.enableKeyboardNavigation) {
                        P()
                    }
                    if (au.clickOnTrack) {
                        p()
                    }
                    B();
                    if (au.hijackInternalLinks) {
                        m()
                    }
                }
                if (au.autoReinitialise && !aq) {
                    aq = setInterval(function() {
                        an(au)
                    }, au.autoReinitialiseDelay)
                } else {
                    if (!au.autoReinitialise && aq) {
                        clearInterval(aq)
                    }
                }
                C.trigger("jsp-initialised", [aB || av])
            }

            function aC() {
                if (av) {
                    aj.append(b('<div class="jspVerticalBar" />').append(b('<div class="jspCap jspCapTop" />'), b('<div class="jspTrack" />').append(b('<div class="jspDrag" />').append(b('<div class="jspDragTop" />'), b('<div class="jspDragBottom" />'))), b('<div class="jspCap jspCapBottom" />')));
                    R = aj.find(">.jspVerticalBar");
                    al = R.find(">.jspTrack");
                    ap = al.find(">.jspDrag");
                    if (au.showArrows) {
                        am = b('<a class="jspArrow jspArrowUp" />').bind("mousedown.jsp", az(0, -1)).bind("click.jsp", ax);
                        ac = b('<a class="jspArrow jspArrowDown" />').bind("mousedown.jsp", az(0, 1)).bind("click.jsp", ax);
                        if (au.arrowScrollOnHover) {
                            am.bind("mouseover.jsp", az(0, -1, am));
                            ac.bind("mouseover.jsp", az(0, 1, ac))
                        }
                        ai(al, au.verticalArrowPositions, am, ac)
                    }
                    t = v;
                    aj.find(">.jspVerticalBar>.jspCap:visible,>.jspVerticalBar>.jspArrow").each(function() {
                        t -= b(this).outerHeight()
                    });
                    ap.hover(function() {
                        ap.addClass("jspHover")
                    }, function() {
                        ap.removeClass("jspHover")
                    }).bind("mousedown.jsp", function(aF) {
                        b("html").bind("dragstart.jsp selectstart.jsp", function() {
                            return false
                        });
                        ap.addClass("jspActive");
                        var s = aF.pageY - ap.position().top;
                        b("html").bind("mousemove.jsp", function(aG) {
                            S(aG.pageY - s, false)
                        }).bind("mouseup.jsp mouseleave.jsp", ar);
                        return false
                    });
                    o()
                }
            }

            function o() {
                al.height(t + "px");
                H = 0;
                U = au.verticalGutter + al.outerWidth();
                V.width(ah - U - g);
                if (R.position().left == 0) {
                    V.css("margin-left", U + "px")
                }
            }

            function z() {
                if (aB) {
                    aj.append(b('<div class="jspHorizontalBar" />').append(b('<div class="jspCap jspCapLeft" />'), b('<div class="jspTrack" />').append(b('<div class="jspDrag" />').append(b('<div class="jspDragLeft" />'), b('<div class="jspDragRight" />'))), b('<div class="jspCap jspCapRight" />')));
                    ak = aj.find(">.jspHorizontalBar");
                    F = ak.find(">.jspTrack");
                    h = F.find(">.jspDrag");
                    if (au.showArrows) {
                        at = b('<a class="jspArrow jspArrowLeft" />').bind("mousedown.jsp", az(-1, 0)).bind("click.jsp", ax);
                        x = b('<a class="jspArrow jspArrowRight" />').bind("mousedown.jsp", az(1, 0)).bind("click.jsp", ax);
                        if (au.arrowScrollOnHover) {
                            at.bind("mouseover.jsp", az(-1, 0, at));
                            x.bind("mouseover.jsp", az(1, 0, x))
                        }
                        ai(F, au.horizontalArrowPositions, at, x)
                    }
                    h.hover(function() {
                        h.addClass("jspHover")
                    }, function() {
                        h.removeClass("jspHover")
                    }).bind("mousedown.jsp", function(aF) {
                        b("html").bind("dragstart.jsp selectstart.jsp", function() {
                            return false
                        });
                        h.addClass("jspActive");
                        var s = aF.pageX - h.position().left;
                        b("html").bind("mousemove.jsp", function(aG) {
                            T(aG.pageX - s, false)
                        }).bind("mouseup.jsp mouseleave.jsp", ar);
                        return false
                    });
                    l = aj.innerWidth();
                    ae()
                } else {}
            }

            function ae() {
                aj.find(">.jspHorizontalBar>.jspCap:visible,>.jspHorizontalBar>.jspArrow").each(function() {
                    l -= b(this).outerWidth()
                });
                F.width(l + "px");
                X = 0
            }

            function E() {
                if (aB && av) {
                    var aF = F.outerHeight(),
                        s = al.outerWidth();
                    t -= aF;
                    b(ak).find(">.jspCap:visible,>.jspArrow").each(function() {
                        l += b(this).outerWidth()
                    });
                    l -= s;
                    v -= s;
                    ah -= aF;
                    F.parent().append(b('<div class="jspCorner" />').css("width", aF + "px"));
                    o();
                    ae()
                }
                if (aB) {
                    V.width((aj.outerWidth() - g) + "px")
                }
                W = V.outerHeight();
                q = W / v;
                if (aB) {
                    ao = 1 / y * l;
                    if (ao > au.horizontalDragMaxWidth) {
                        ao = au.horizontalDragMaxWidth
                    } else {
                        if (ao < au.horizontalDragMinWidth) {
                            ao = au.horizontalDragMinWidth
                        }
                    }
                    h.width(ao + "px");
                    j = l - ao;
                    ab(X)
                }
                if (av) {
                    A = 1 / q * t;
                    if (A > au.verticalDragMaxHeight) {
                        A = au.verticalDragMaxHeight
                    } else {
                        if (A < au.verticalDragMinHeight) {
                            A = au.verticalDragMinHeight
                        }
                    }
                    ap.height(A + "px");
                    i = t - A;
                    aa(H)
                }
            }

            function ai(aG, aI, aF, s) {
                var aK = "before",
                    aH = "after",
                    aJ;
                if (aI == "os") {
                    aI = /Mac/.test(navigator.platform) ? "after" : "split"
                }
                if (aI == aK) {
                    aH = aI
                } else {
                    if (aI == aH) {
                        aK = aI;
                        aJ = aF;
                        aF = s;
                        s = aJ
                    }
                }
                aG[aK](aF)[aH](s)
            }

            function az(aF, s, aG) {
                return function() {
                    G(aF, s, this, aG);
                    this.blur();
                    return false
                }
            }

            function G(aH, aF, aK, aJ) {
                aK = b(aK).addClass("jspActive");
                var aI, s = function() {
                        if (aH != 0) {
                            T(X + aH * au.arrowButtonSpeed, false)
                        }
                        if (aF != 0) {
                            S(H + aF * au.arrowButtonSpeed, false)
                        }
                    },
                    aG = setInterval(s, au.arrowRepeatFreq);
                s();
                aI = aJ == c ? "mouseup.jsp" : "mouseout.jsp";
                aJ = aJ || b("html");
                aJ.bind(aI, function() {
                    aK.removeClass("jspActive");
                    clearInterval(aG);
                    aJ.unbind(aI)
                })
            }

            function p() {
                w();
                if (av) {
                    al.bind("mousedown.jsp", function(aH) {
                        if (aH.originalTarget == c || aH.originalTarget == aH.currentTarget) {
                            var aG = b(this),
                                s = setInterval(function() {
                                    var aI = aG.offset(),
                                        aJ = aH.pageY - aI.top;
                                    if (H + A < aJ) {
                                        S(H + au.trackClickSpeed)
                                    } else {
                                        if (aJ < H) {
                                            S(H - au.trackClickSpeed)
                                        } else {
                                            aF()
                                        }
                                    }
                                }, au.trackClickRepeatFreq),
                                aF = function() {
                                    s && clearInterval(s);
                                    s = null;
                                    b(document).unbind("mouseup.jsp", aF)
                                };
                            b(document).bind("mouseup.jsp", aF);
                            return false
                        }
                    })
                }
                if (aB) {
                    F.bind("mousedown.jsp", function(aH) {
                        if (aH.originalTarget == c || aH.originalTarget == aH.currentTarget) {
                            var aG = b(this),
                                s = setInterval(function() {
                                    var aI = aG.offset(),
                                        aJ = aH.pageX - aI.left;
                                    if (X + ao < aJ) {
                                        T(X + au.trackClickSpeed)
                                    } else {
                                        if (aJ < X) {
                                            T(X - au.trackClickSpeed)
                                        } else {
                                            aF()
                                        }
                                    }
                                }, au.trackClickRepeatFreq),
                                aF = function() {
                                    s && clearInterval(s);
                                    s = null;
                                    b(document).unbind("mouseup.jsp", aF)
                                };
                            b(document).bind("mouseup.jsp", aF);
                            return false
                        }
                    })
                }
            }

            function w() {
                F && F.unbind("mousedown.jsp");
                al && al.unbind("mousedown.jsp")
            }

            function ar() {
                b("html").unbind("dragstart.jsp selectstart.jsp mousemove.jsp mouseup.jsp mouseleave.jsp");
                ap && ap.removeClass("jspActive");
                h && h.removeClass("jspActive")
            }

            function S(s, aF) {
                if (!av) {
                    return
                }
                if (s < 0) {
                    s = 0
                } else {
                    if (s > i) {
                        s = i
                    }
                }
                if (aF == c) {
                    aF = au.animateScroll
                }
                if (aF) {
                    N.animate(ap, "top", s, aa)
                } else {
                    ap.css("top", s);
                    aa(s)
                }
            }

            function aa(aF) {
                if (aF == c) {
                    aF = ap.position().top
                }
                aj.scrollTop(0);
                H = aF;
                var aI = H == 0,
                    aG = H == i,
                    aH = aF / i,
                    s = -aH * (W - v);
                if (ag != aI || aD != aG) {
                    ag = aI;
                    aD = aG;
                    C.trigger("jsp-arrow-change", [ag, aD, M, k])
                }
                u(aI, aG);
                V.css("top", s);
                C.trigger("jsp-scroll-y", [-s, aI, aG])
            }

            function T(aF, s) {
                if (!aB) {
                    return
                }
                if (aF < 0) {
                    aF = 0
                } else {
                    if (aF > j) {
                        aF = j
                    }
                }
                if (s == c) {
                    s = au.animateScroll
                }
                if (s) {
                    N.animate(h, "left", aF, ab)
                } else {
                    h.css("left", aF);
                    ab(aF)
                }
            }

            function ab(aF) {
                if (aF == c) {
                    aF = h.position().left
                }
                aj.scrollTop(0);
                X = aF;
                var aI = X == 0,
                    aH = X == j,
                    aG = aF / j,
                    s = -aG * (Q - ah);
                if (M != aI || k != aH) {
                    M = aI;
                    k = aH;
                    C.trigger("jsp-arrow-change", [ag, aD, M, k])
                }
                r(aI, aH);
                V.css("left", s);
                C.trigger("jsp-scroll-x", [-s, aI, aH])
            }

            function u(aF, s) {
                if (au.showArrows) {
                    am[aF ? "addClass" : "removeClass"]("jspDisabled");
                    ac[s ? "addClass" : "removeClass"]("jspDisabled")
                }
            }

            function r(aF, s) {
                if (au.showArrows) {
                    at[aF ? "addClass" : "removeClass"]("jspDisabled");
                    x[s ? "addClass" : "removeClass"]("jspDisabled")
                }
            }

            function J(s, aF) {
                var aG = s / (W - v);
                S(aG * i, aF)
            }

            function K(aF, s) {
                var aG = aF / (Q - ah);
                T(aG * j, s)
            }

            function Y(aN, aL, aF) {
                var aJ, aH, s = 0,
                    aG, aK, aM;
                try {
                    aJ = b(aN)
                } catch (aI) {
                    return
                }
                aH = aJ.outerHeight();
                aj.scrollTop(0);
                while (!aJ.is(".jspPane")) {
                    s += aJ.position().top;
                    aJ = aJ.offsetParent();
                    if (/^body|html$/i.test(aJ[0].nodeName)) {
                        return
                    }
                }
                aG = aw();
                aK = aG + v;
                if (s < aG || aL) {
                    aM = s - au.verticalGutter
                } else {
                    if (s + aH > aK) {
                        aM = s - v + aH + au.verticalGutter
                    }
                }
                if (aM) {
                    J(aM, aF)
                }
            }

            function ay() {
                return -V.position().left
            }

            function aw() {
                return -V.position().top
            }

            function ad() {
                aj.unbind(Z).bind(Z, function(aI, aJ, aH, aF) {
                    var aG = X,
                        s = H;
                    T(X + aH * au.mouseWheelSpeed, false);
                    S(H - aF * au.mouseWheelSpeed, false);
                    return aG == X && s == H
                })
            }

            function n() {
                aj.unbind(Z)
            }

            function ax() {
                return false
            }

            function I() {
                V.unbind("focusin.jsp").bind("focusin.jsp", function(s) {
                    if (s.target === V[0]) {
                        return
                    }
                    Y(s.target, false)
                })
            }

            function D() {
                V.unbind("focusin.jsp")
            }

            function P() {
                var aF, s;
                C.attr("tabindex", 0).unbind("keydown.jsp").bind("keydown.jsp", function(aJ) {
                    if (aJ.target !== C[0]) {
                        return
                    }
                    var aH = X,
                        aG = H,
                        aI = aF ? 2 : 16;
                    switch (aJ.keyCode) {
                        case 40:
                            S(H + aI, false);
                            break;
                        case 38:
                            S(H - aI, false);
                            break;
                        case 34:
                        case 32:
                            J(aw() + Math.max(32, v) - 16);
                            break;
                        case 33:
                            J(aw() - v + 16);
                            break;
                        case 35:
                            J(W - v);
                            break;
                        case 36:
                            J(0);
                            break;
                        case 39:
                            T(X + aI, false);
                            break;
                        case 37:
                            T(X - aI, false);
                            break
                    }
                    if (!(aH == X && aG == H)) {
                        aF = true;
                        clearTimeout(s);
                        s = setTimeout(function() {
                            aF = false
                        }, 260);
                        return false
                    }
                });
                if (au.hideFocus) {
                    C.css("outline", "none");
                    if ("hideFocus" in aj[0]) {
                        C.attr("hideFocus", true)
                    }
                } else {
                    C.css("outline", "");
                    if ("hideFocus" in aj[0]) {
                        C.attr("hideFocus", false)
                    }
                }
            }

            function O() {
                C.attr("tabindex", "-1").removeAttr("tabindex").unbind("keydown.jsp")
            }

            function B() {
                if (location.hash && location.hash.length > 1) {
                    var aG, aF;
                    try {
                        aG = b(location.hash)
                    } catch (s) {
                        return
                    }
                    if (aG.length && V.find(aG)) {
                        if (aj.scrollTop() == 0) {
                            aF = setInterval(function() {
                                if (aj.scrollTop() > 0) {
                                    Y(location.hash, true);
                                    b(document).scrollTop(aj.position().top);
                                    clearInterval(aF)
                                }
                            }, 50)
                        } else {
                            Y(location.hash, true);
                            b(document).scrollTop(aj.position().top)
                        }
                    }
                }
            }

            function af() {
                b("a.jspHijack").unbind("click.jsp-hijack").removeClass("jspHijack")
            }

            function m() {
                af();
                b("a[href^=#]").addClass("jspHijack").bind("click.jsp-hijack", function() {
                    var s = this.href.split("#"),
                        aF;
                    if (s.length > 1) {
                        aF = s[1];
                        if (aF.length > 0 && V.find("#" + aF).length > 0) {
                            Y("#" + aF, true);
                            return false
                        }
                    }
                })
            }
            b.extend(N, {
                reinitialise: function(aF) {
                    aF = b.extend({}, aF, au);
                    an(aF)
                },
                scrollToElement: function(aG, aF, s) {
                    Y(aG, aF, s)
                },
                scrollTo: function(aG, s, aF) {
                    K(aG, aF);
                    J(s, aF)
                },
                scrollToX: function(aF, s) {
                    K(aF, s)
                },
                scrollToY: function(s, aF) {
                    J(s, aF)
                },
                scrollBy: function(aF, s, aG) {
                    N.scrollByX(aF, aG);
                    N.scrollByY(s, aG)
                },
                scrollByX: function(s, aG) {
                    var aF = ay() + s,
                        aH = aF / (Q - ah);
                    T(aH * j, aG)
                },
                scrollByY: function(s, aG) {
                    var aF = aw() + s,
                        aH = aF / (W - v);
                    S(aH * i, aG)
                },
                animate: function(aF, aI, s, aH) {
                    var aG = {};
                    aG[aI] = s;
                    aF.animate(aG, {
                        duration: au.animateDuration,
                        ease: au.animateEase,
                        queue: false,
                        step: aH
                    })
                },
                getContentPositionX: function() {
                    return ay()
                },
                getContentPositionY: function() {
                    return aw()
                },
                getIsScrollableH: function() {
                    return aB
                },
                getIsScrollableV: function() {
                    return av
                },
                getContentPane: function() {
                    return V
                },
                scrollToBottom: function(s) {
                    S(i, s)
                },
                hijackInternalLinks: function() {
                    m()
                }
            })
        }
        f = b.extend({}, b.fn.jScrollPane.defaults, f);
        var e;
        this.each(function() {
            var g = b(this),
                h = g.data("jsp");
            if (h) {
                h.reinitialise(f)
            } else {
                h = new d(g, f);
                g.data("jsp", h)
            }
            e = e ? e.add(g) : g
        });
        return e
    };
    b.fn.jScrollPane.defaults = {
        showArrows: false,
        maintainPosition: true,
        clickOnTrack: true,
        autoReinitialise: false,
        autoReinitialiseDelay: 500,
        verticalDragMinHeight: 0,
        verticalDragMaxHeight: 99999,
        horizontalDragMinWidth: 0,
        horizontalDragMaxWidth: 99999,
        animateScroll: false,
        animateDuration: 300,
        animateEase: "linear",
        hijackInternalLinks: false,
        verticalGutter: 4,
        horizontalGutter: 4,
        mouseWheelSpeed: 10,
        arrowButtonSpeed: 10,
        arrowRepeatFreq: 100,
        arrowScrollOnHover: false,
        trackClickSpeed: 30,
        trackClickRepeatFreq: 100,
        verticalArrowPositions: "split",
        horizontalArrowPositions: "split",
        enableKeyboardNavigation: true,
        hideFocus: false
    }
})(jQuery, this);