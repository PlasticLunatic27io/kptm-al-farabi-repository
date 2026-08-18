
# Browse views. allow_null indicates that no value set is 
# a valid result. 
# Multiple fields may be specified for one view, but avoid
# subject or allowing null in this case.



##
# set a global max_items limit:
#	$c->{browse_views_max_items} = 3000;

# set a per view max_item limit:
#        $c->{browse_views} = [{
#                ...
#                max_items => 3000,
#        }];
# To disable the limit set max_items to 0.


$c->{browse_views} = [

    # =========================================================
    # BROWSE BY ITEM TYPE
    # =========================================================
    {
        id => "type",
        menus => [
            {
                fields => [ "type" ],
                hideempty => 1,
            }
        ],
        order => "-date/title",
    },


    # =========================================================
    # BROWSE BY SUBJECT
    # =========================================================
    {
        id => "subjects",
        menus => [
            {
                fields => [ "subjects" ],
                hideempty => 1,
            }
        ],
        order => "-date/title",
        include => 1,
        variations => [
            "type",
        ],
    },


    # =========================================================
    # BROWSE BY YEAR
    # =========================================================
#    {
#        id => "year",
#        menus => [
#            {
#                fields => [ "date;res=year" ],
#                reverse_order => 1,
#                allow_null => 1,
#            }
#        ],
#        order => "-date/title",
#        variations => [
#            "type",
#            "DEFAULT",
#        ],
#    },


    # =========================================================
    # BROWSE BY AUTHOR
    # =========================================================
#            {
#    id => "author",
#
#    menus => [
#        {
#            fields => [ "creators_name" ],
#
#            allow_null => 0,
#
#            grouping_function =>
#                "EPrints::Update::Views::group_by_3_characters",
#
#            group_range_function =>
#                "EPrints::Update::Views::cluster_ranges_30",

#            mode => "sections",
#            open_first_section => 1,

#            new_column_at => [0,0],
#        }
#    ],

#    order => "-date/title",
#},

];


=head1 COPYRIGHT

=for COPYRIGHT BEGIN

Copyright 2022 University of Southampton.
EPrints 3.4 is supplied by EPrints Services.

http://www.eprints.org/eprints-3.4/

=for COPYRIGHT END

=for LICENSE BEGIN

This file is part of EPrints 3.4 L<http://www.eprints.org/>.

EPrints 3.4 and this file are released under the terms of the
GNU Lesser General Public License version 3 as published by
the Free Software Foundation unless otherwise stated.

EPrints 3.4 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with EPrints 3.4.
If not, see L<http://www.gnu.org/licenses/>.

=for LICENSE END

