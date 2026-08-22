# ============================================================
# KPTM AL-FARABI
# Dynamic template pins
#
# English pins:
#   kptm_user_identity_en
#   kptm_public_mode_control_en
#
# Malay pins:
#   kptm_user_identity_ms
#   kptm_public_mode_control_ms
# ============================================================

$c->{dynamic_template}->{enable} = 1;

$c->{dynamic_template}->{function} = sub
{
    my( $repo, $parts ) = @_;

    # --------------------------------------------------------
    # Always initialise every pin as empty.
    # Anonymous/public visitors therefore get no staff UI.
    # --------------------------------------------------------

    foreach my $pin (
        "kptm_user_identity_en",
        "kptm_user_identity_ms",
        "kptm_public_mode_control_en",
        "kptm_public_mode_control_ms"
    )
    {
        $parts->{$pin} =
            $repo->make_doc_fragment();
    }


    my $user =
        $repo->current_user;

    return unless defined $user;


    # --------------------------------------------------------
    # REAL EPrints account
    # --------------------------------------------------------

    my $username =
        $user->get_value( "username" );

    my $usertype =
        $user->get_value( "usertype" );


    $username = "Staff"
        if !defined $username ||
           $username eq "";

    $usertype = ""
        if !defined $usertype;


    # Al-Farabi privilege mapping:
    #
    # editor = Staff
    # admin  = Technical Admin
    #
    # Other EPrints user types do not receive staff controls.
    # --------------------------------------------------------

    return
        unless
            $usertype eq "editor" ||
            $usertype eq "admin";


    my $profile_url =
        $repo->config( "rel_cgipath" ) .
        "/users/home?screen=User::View";

    my $workspace_url =
        $repo->config( "rel_cgipath" ) .
        "/users/home";


    # ========================================================
    # IDENTITY BUILDER
    # ========================================================

    my $build_identity = sub
    {
        my( $hello_word, $role_label ) = @_;

        my $fragment =
            $repo->make_doc_fragment();


        my $chip =
            $repo->make_element(
                "a",
                href => $profile_url,
                class => "kptm-user-chip",
                "data-kptm-role" => $usertype,
            );


        my $hello =
            $repo->make_element(
                "span",
                class => "kptm-user-chip-hello",
            );

        $hello->appendChild(
            $repo->make_text(
                "$hello_word, $username"
            )
        );


        my $role =
            $repo->make_element(
                "span",
                class => "kptm-user-chip-role",
            );

        $role->appendChild(
            $repo->make_text(
                $role_label
            )
        );


        $chip->appendChild( $hello );
        $chip->appendChild( $role );

        $fragment->appendChild( $chip );

        return $fragment;
    };


    # ========================================================
    # PUBLIC MODE SWITCH BUILDER
    # ========================================================

    my $build_public_mode = sub
    {
        my(
            $view_label,
            $workspace_label,
            $public_label,
            $workspace_title,
            $aria_label
        ) = @_;


        my $fragment =
            $repo->make_doc_fragment();


        my $mode =
            $repo->make_element(
                "div",
                class => "kptm-public-mode-control",
                "aria-label" => $aria_label,
            );


        my $eyebrow =
            $repo->make_element(
                "div",
                class => "kptm-mode-eyebrow",
            );

        $eyebrow->appendChild(
            $repo->make_text(
                $view_label
            )
        );


        my $segments =
            $repo->make_element(
                "div",
                class => "kptm-mode-segmented",
            );


        # ----------------------------------------------------
        # Workspace side
        # ----------------------------------------------------

        my $workspace =
            $repo->make_element(
                "a",
                href => $workspace_url,
                class => "kptm-mode-choice",
                title => $workspace_title,
            );


        my $workspace_dot =
            $repo->make_element(
                "span",
                class => "kptm-mode-power",
            );

        $workspace_dot->appendChild(
            $repo->make_text( "●" )
        );

        $workspace->appendChild(
            $workspace_dot
        );

        $workspace->appendChild(
            $repo->make_text(
                $workspace_label
            )
        );


        # ----------------------------------------------------
        # Public side = current/active
        # ----------------------------------------------------

        my $public =
            $repo->make_element(
                "span",
                class => "kptm-mode-choice is-active",
                "aria-current" => "page",
            );


        my $public_dot =
            $repo->make_element(
                "span",
                class => "kptm-mode-indicator",
            );

        $public->appendChild(
            $public_dot
        );

        $public->appendChild(
            $repo->make_text(
                $public_label
            )
        );


        $segments->appendChild(
            $workspace
        );

        $segments->appendChild(
            $public
        );


        $mode->appendChild(
            $eyebrow
        );

        $mode->appendChild(
            $segments
        );


        $fragment->appendChild(
            $mode
        );

        return $fragment;
    };


    # ========================================================
    # ENGLISH
    # ========================================================

    my $role_en =
        $usertype eq "admin"
        ? "Technical Admin"
        : "Staff";


    $parts->{kptm_user_identity_en} =
        $build_identity->(
            "Hi",
            $role_en
        );


    $parts->{kptm_public_mode_control_en} =
        $build_public_mode->(
            "VIEW MODE",
            "Workspace",
            "Public",
            "Switch to Staff Workspace",
            "Interface mode"
        );


    # ========================================================
    # BAHASA MELAYU
    # ========================================================

    my $role_ms =
        $usertype eq "admin"
        ? "Pentadbir Teknikal"
        : "Staf";


    $parts->{kptm_user_identity_ms} =
        $build_identity->(
            "Hai",
            $role_ms
        );


    $parts->{kptm_public_mode_control_ms} =
        $build_public_mode->(
            "MOD PAPARAN",
            "Ruang Kerja",
            "Awam",
            "Tukar ke Ruang Kerja Staf",
            "Mod antara muka"
        );
};
