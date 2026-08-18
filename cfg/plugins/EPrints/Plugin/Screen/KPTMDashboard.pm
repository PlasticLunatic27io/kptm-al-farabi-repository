package EPrints::Plugin::Screen::KPTMDashboard;

use EPrints::Plugin::Screen;

@ISA = ( 'EPrints::Plugin::Screen' );

use strict;


sub new
{
    my( $class, %params ) = @_;

    my $self = $class->SUPER::new( %params );

    $self->{appears} = [];

    return $self;
}


sub can_be_viewed
{
    my( $self ) = @_;

    return defined $self->{session}->current_user;
}


sub render_title
{
    my( $self ) = @_;

    return $self->{session}->make_text(
        "Staff Dashboard"
    );
}


sub render
{
    my( $self ) = @_;

    my $repo = $self->{session};
    my $user = $repo->current_user;

    my $html = $repo->make_doc_fragment;


    # =========================================================
    # MAIN DASHBOARD WRAPPER
    # =========================================================

    my $dashboard = $repo->make_element(
        "div",
        class => "kptm-staff-dashboard"
    );


    # =========================================================
    # WELCOME SECTION
    # =========================================================

    my $welcome = $repo->make_element(
        "div",
        class => "kptm-dashboard-welcome"
    );

    my $eyebrow = $repo->make_element(
        "div",
        class => "kptm-dashboard-eyebrow"
    );

    $eyebrow->appendChild(
        $repo->make_text( "KPTM BATU PAHAT" )
    );

    $welcome->appendChild( $eyebrow );


    my $heading = $repo->make_element(
        "h2",
        class => "kptm-dashboard-title"
    );

    $heading->appendChild(
        $repo->make_text( "Repository Staff Workspace" )
    );

    $welcome->appendChild( $heading );


    my $intro = $repo->make_element(
        "p",
        class => "kptm-dashboard-description"
    );

    $intro->appendChild(
        $repo->make_text(
            "Manage repository items, deposits and submissions from one place."
        )
    );

    $welcome->appendChild( $intro );

    $dashboard->appendChild( $welcome );


    # =========================================================
    # QUICK ACTIONS
    # =========================================================

    my $actions = $repo->make_element(
        "div",
        class => "kptm-dashboard-actions"
    );


    # ADD NEW ITEM

    $actions->appendChild(
        $self->render_dashboard_card(
            "＋",
            "Add New Item",
            "Create and upload a new repository record.",
            $repo->config( "rel_cgipath" ) .
                "/users/home?screen=NewEPrint"
        )
    );


    # MANAGE DEPOSITS

    $actions->appendChild(
        $self->render_dashboard_card(
            "▣",
            "Manage Deposits",
            "View, edit and manage your repository records.",
            $repo->config( "rel_cgipath" ) .
                "/users/home?screen=Items"
        )
    );


    # REVIEW ITEMS

    if(
        $repo->current_user->has_role( "editor" )
        ||
        $repo->current_user->has_role( "admin" )
    )
    {
        $actions->appendChild(
            $self->render_dashboard_card(
                "✓",
                "Review Items",
                "Review submissions awaiting approval.",
                $repo->config( "rel_cgipath" ) .
                    "/users/home?screen=Review"
            )
        );
    }


    # BROWSE PUBLIC REPOSITORY

    $actions->appendChild(
        $self->render_dashboard_card(
            "◎",
            "Browse Repository",
            "View the repository as visitors see it.",
            $repo->config( "rel_path" ) . "/view/"
        )
    );


    $dashboard->appendChild( $actions );


    # =========================================================
    # ACCOUNT LINKS
    # =========================================================

    my $footer = $repo->make_element(
        "div",
        class => "kptm-dashboard-footer"
    );

    my $profile = $repo->render_link(
        $repo->config( "rel_cgipath" ) .
        "/users/home?screen=User::View"
    );

    $profile->appendChild(
        $repo->make_text( "Profile" )
    );

    $footer->appendChild( $profile );


    $footer->appendChild(
        $repo->make_text( "  ·  " )
    );


    my $logout = $repo->render_link(
        $repo->config( "rel_cgipath" ) .
        "/users/home?screen=Logout"
    );

    $logout->appendChild(
        $repo->make_text( "Logout" )
    );

    $footer->appendChild( $logout );


    $dashboard->appendChild( $footer );

    $html->appendChild( $dashboard );

    return $html;
}


sub render_dashboard_card
{
    my(
        $self,
        $icon,
        $title,
        $description,
        $url
    ) = @_;

    my $repo = $self->{session};

    my $link = $repo->render_link( $url );

    $link->setAttribute(
        "class",
        "kptm-dashboard-card"
    );


    my $icon_el = $repo->make_element(
        "span",
        class => "kptm-dashboard-card-icon"
    );

    $icon_el->appendChild(
        $repo->make_text( $icon )
    );

    $link->appendChild( $icon_el );


    my $content = $repo->make_element(
        "span",
        class => "kptm-dashboard-card-content"
    );


    my $title_el = $repo->make_element(
        "strong",
        class => "kptm-dashboard-card-title"
    );

    $title_el->appendChild(
        $repo->make_text( $title )
    );

    $content->appendChild( $title_el );


    my $desc = $repo->make_element(
        "span",
        class => "kptm-dashboard-card-description"
    );

    $desc->appendChild(
        $repo->make_text( $description )
    );

    $content->appendChild( $desc );

    $link->appendChild( $content );


    my $arrow = $repo->make_element(
        "span",
        class => "kptm-dashboard-card-arrow"
    );

    $arrow->appendChild(
        $repo->make_text( "→" )
    );

    $link->appendChild( $arrow );


    return $link;
}


1;
