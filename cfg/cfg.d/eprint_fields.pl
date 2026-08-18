
push @{$c->{fields}->{eprint}},

{
	name => 'title',
	type => 'longtext',
	input_rows => 3,
	make_single_value_orderkey => 'EPrints::Extras::english_title_orderkey',
},
{
	name => 'subjects',
	type => 'subject',
	multiple => 1,
	top => 'subjects',
	browse_link => 'subjects',
},

{
        name => 'creators',
        type => 'compound',
        multiple => 1,
        fields => [
                {
                        sub_name => 'name',
                        type => 'name',
                        hide_honourific => 1,
                        hide_lineage => 1,
                        family_first => 1,
                },
                {
                        sub_name => 'id',
                        type => 'text',
                        input_cols => 30,
                        allow_null => 1,
                },
        ],
        input_boxes => 3,
},

{
        name => 'date',
        type => 'date',
        min_resolution => 'year',
},

{
        name => 'programme',
        type => 'set',
        options => [
                'dcs',
                'dhr',
                'dcgd',
                'dit',
        ],
},

;

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

