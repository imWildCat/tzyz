(function () {
    var ready;
    ready = function () {
        $.extend({
            enable_at_user: function () {
                // only enable once
                if (window.has_enabled_at_user)
                    return;
                //$('[contenteditable="true"]').on('blur keyup paste', function() {
                //    $(this).html($(this).html().replace(/@/g, '[at]'));
                //});
                $('[contenteditable="true"]').textcomplete([
                    {
                        match: /\B@([\u4e00-\u9fa5\w]{1,20})$/,
                        search: function (term, callback) {
                            //console.log('term is: '+ term);
                            var callCb = function (data) {
                                $.setCurrentUserTerm(data);
                                var mentions = [];
                                for (var i = 0; i < data.length; i++) {
                                    mentions.push(data[i].title);
                                }
                                callback($.map(mentions, function (mention) {
                                    return mention;
                                }));
                            };
                            // Initilize cache
                            if (!window.userTermCache) {
                                //console.log('init cache');
                                window.userTermCache = {};
                            }
                            // If there is a cached data, load form it
                            if (window.userTermCache[term] != null) {
                                //console.log('load from cache');
                                callCb(window.userTermCache[term]);
                                return;
                            }
                            $.ajax({
                                dataType: 'json',
                                url: '/quick_search/u?q=' + term,
                            }).done(function (data) {
                                //console.log('load from server');
                                window.userTermCache[term] = data;
                                callCb(data);
                            });
                        },
                        index: 1,
                        template: function (mention) {
                            var currentUser = $.fetchCurrentUserTerm(mention);
                            var output;
                            if (currentUser) {
                                output = mention + ' [<span style="font-weight:bold">' + currentUser.id + '</span>]';
                            }
                            else output = mention;
                            return output;
                        },
                        replace: function (mention) {
                            var currentUser = $.fetchCurrentUserTerm(mention);
                            return '@' + mention + '[' + currentUser.id + ']';
                        }
                    }
                ], {appendTo: 'body'});

                // not working
                //$('[contenteditable="true"]').overlay([
                //    {
                //        match: /\B@\w+/g,
                //        css: {
                //            'background-color': '#d8dfea'
                //        }
                //    }
                //]);

                window.has_enabled_at_user = true;
            },
            currentUserTermData: [],
            setCurrentUserTerm: function (data) {
                $.currentUserTermData = {};
                for(var i = 0; i < data.length; i++) {
                    $.currentUserTermData[data[i].title] = data[i]
                }
            },
            fetchCurrentUserTerm: function (mention) {
                if ($.currentUserTermData && $.currentUserTermData[mention]) {
                    return $.currentUserTermData[mention];
                }
                return null;
            }
            //disable_at_user: function () {
            //    $('[contenteditable="true"]').textcomplete('destroy');
            //}
        });

    };

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();