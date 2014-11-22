package Desktop::Detect;

our $DATE = '2014-11-22'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(detect_desktop); # detect_desktop_cached

#my $dd_cache;
#sub detect_desktop_cached {
#    if (!$dd_cache) {
#        $dd_cache = detect_desktop(@_);
#    }
#    $dd_cache;
#}

sub detect_desktop {
    my @dbg;
    my $info = {_debug_info=>\@dbg};

  DETECT:
    {
        if (($ENV{XDG_MENU_PREFIX}//'') =~ /^xfce-/) {
            push @dbg, "detect: xfce via XDG_MENU_PREFIX env";
            $info->{desktop} = 'xfce';
            last DETECT;
        }

        if (($ENV{XDG_DESKTOP_SESSION}//'') =~ /^kde-plasma/) {
            push @dbg, "detect: kde-plasma via XDG_DESKTOP_SESSION env";
            $info->{desktop} = 'kde-plasma';
            last DETECT;
        }
        if (($ENV{DESKTOP_SESSION}//'') =~ /^kde-plasma/) {
            push @dbg, "detect: kde-plasma via DESKTOP_SESSION env";
            $info->{desktop} = 'kde-plasma';
            last DETECT;
        }

        push @dbg, "detect: nothing detected";
    } # DETECT

    $info;
}

1;
#ABSTRACT: Detect desktop environment currently running

__END__

=pod

=encoding UTF-8

=head1 NAME

Desktop::Detect - Detect desktop environment currently running

=head1 VERSION

This document describes version 0.01 of Desktop::Detect (from Perl distribution Desktop-Detect), released on 2014-11-22.

=head1 SYNOPSIS

 use Desktop::Detect qw(detect_desktop);
 my $res = detect_desktop();

=head1 DESCRIPTION

This module uses several heuristics to find out what desktop environment
is currently running, along with extra information.

=head1 FUNCTIONS

=head2 detect_desktop() => HASHREF

Return a hashref containing information about running desktop environment and
extra information. Return empty hashref if not detected running under any
desktop environment.

Detection is done from the cheapest methods, e.g. looking at environment
variables. Several environment variables are checked, e.g. C<DESKTOP_SESSION>,
C<XDG_DESKTOP_SESSION>, etc.

Result:

=over

=item * desktop => STR

Possible values: xfce, kde-plasma.

=back

=head1 TODO

=over

=item * Window manager information

=item * XFCE: version

=item * Detect GNOME

=item * Detect MATE

=item * Detect Unity

=item * Detect LXDE

=item * Detect Cinnamon

=item * Detect JWM

=item * Detect Windows?

=back

=head1 SEE ALSO

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Desktop-Detect>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Desktop-Detect>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Desktop-Detect>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
