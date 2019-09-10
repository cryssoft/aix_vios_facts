#
#  FACT(S):     aix_vios
#
#  PURPOSE:     This custom fact returns information about whether this AIX
#		instance is a VIO server or not, the installed CLI package
#		version and the VIOS version if applicable.
#
#  RETURNS:     (hash)
#
#  AUTHOR:      Chris Petersen, Crystallized Software
#
#  DATE:        June 12, 2019
#
#  NOTES:       Myriad names and acronyms are trademarked or copyrighted by IBM
#               including but not limited to IBM, PowerHA, AIX, RSCT (Reliable,
#               Scalable Cluster Technology), and CAA (Cluster-Aware AIX).  All
#               rights to such names and acronyms belong with their owner.
#
#-------------------------------------------------------------------------------
#
#  LAST MOD:    (never)
#
#  MODIFICATION HISTORY:
#
#	(none)
#
#-------------------------------------------------------------------------------
#
Facter.add(:aix_vios) do
    #  This only applies to the AIX operating system
    confine :osfamily => 'AIX'

    #  Capture the installation status and version if it's there
    setcode do
        #  Define the hash we'll fill and return
        l_aixViosHash = {}

        #  Fill the only things we can really default
        l_aixViosHash['cli_version'] = ''
        l_aixViosHash['is_vios']     = false
        l_aixViosHash['version']     = ''

        #  Look for the VIOS command-line interface package
        l_lines = Facter::Util::Resolution.exec('/bin/lslpp -lc ios.cli.rte 2>/dev/null')

        #  Loop over the lines that were returned
        l_lines && l_lines.split("\n").each do |l_oneLine|
            #  Skip comments and blanks
            l_oneLine = l_oneLine.strip()
            next if l_oneLine =~ /^#/ or l_oneLine =~ /^$/

            #  Split regular lines, and stash the relevant fields
            l_list       = l_oneLine.split(":")
            l_package    = l_list[1]
            l_cliVersion = l_list[2]

            #  Let's just double-check the package name
            if l_package == 'ios.cli.rte'
                l_aixViosHash['is_vios']     = true
                l_aixViosHash['cli_version'] = l_cliVersion
            end
        end

        #  If we're a VIO server, collect the 'ioslevel' that we should report
        if l_aixViosHash['is_vios']
            #  Grab the reportable, human-readable value
            l_lines = Facter::Util::Resolution.exec('/usr/ios/cli/ioscli ioslevel 2>/dev/null')

            #  Loop over the lines that were returned - should be only one
            l_lines && l_lines.split("\n").each do |l_oneLine|
                l_aixViosHash['version']=l_oneLine
            end
        end

        #  Implicitly return the contents of the hash
        l_aixViosHash
    end
end
