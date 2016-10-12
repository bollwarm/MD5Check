# MD5Check

=head1 NAME
 
MD5Check - Use it for init Web files's md5 values of your site(or other dir), and check if it changed.
 
 
=head1 SYNOPSIS
 
    use MD5Check;
 
    my $mydir=shift;
    md5init($mydir);
 
    use MD5Check;
    my $mydir=shift; 
    md5check($mydir);

    # oneliner

    $ perl -MMD5Check -e 'md5init("/web")' >file
    $ perl -MMD5Check -e 'md5check(file)'
 
=head1 DESCRIPTION
 
MD5Check - Use it for init Web files's md5 values of your site(or other dir), and check if it changed.
 
MD5Check is not standardized. This module is far from complete.
 
 
=head2 IMPLEMENTATION
     
    use MD5Check;
 
    my $mydir=shift;
    md5init($mydir);
 
    use MD5Check;
    my $mydir=shift; 
    md5check($mydir);

=head1 Git repo
 
L<http://github.com/a3f/MD5Check>
 
=head1 AUTHOR
 
orange C<< <linzhe@ijz.me> >>, L<http://ijz.me>
 
=head1 COPYRIGHT AND LICENSE
 
Copyright (C) 2016 linzhe
 
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
 
 
=cut
