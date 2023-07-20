If you've made changes to gem5 that might benefit others, we strongly encourage
you to contribute those changes to the public gem5 repository. There are
several reasons to do this:
 * Share your work with others, so that they can benefit from new functionality.
 * Support the scientific principle by enabling others to evaluate your
   suggestions without having to guess what you did.
 * Once your changes are part of the main repo, you no longer have to merge
   them back in every time you update your local repo. This can be a huge time
   saving!
 * Once your code is in the main repo, other people have to make their changes
   work with your code, and not the other way around.
 * Others may build on your contributions to make them even better, or extend
   them in ways you did not have time to do.
 * You will have the satisfaction of contributing back to the community.

The main method for contributing code to gem5 is via our code review website:
https://github.com/gem5/gem5/pulls/. This documents describes the details of
how to create code changes, upload your changes, have your changes
reviewed, and finally push your changes to gem5. More information can be found
from the following sources:
 * http://gem5.org/contributing
 * https://docs.github.com/en/pull-requests
 * https://git-scm.com/book


High-level flow for submitting changes
======================================

    +-------------+
    | Make change |
    +------+------+
           |
           |
           v
    +-------------+
    |  Run tests  |<--------------+
    +------+------+               |
           |                      |
           |                      |
           v                      |
    +------+------+               |
    | Post review |               |
    +------+------+               |
           |                      |
           v                      |
    +--------+---------+          |
    | Wait for reviews |          |
    +--------+---------+          |
           |                      |
           |                      |
           v                      |
      +----+----+   No     +------+------+
      |Reviewers+--------->+ Update code |
      |happy?   |          +------+------+
      +----+----+                 ^
           |                      |
           | Yes                  |
           v                      |
      +----+-----+   No           |
      |Maintainer+----------------+
      |happy?    |
      +----+-----+
           |
           | Yes
           v
    +------+------+
    | Submit code |
    +-------------+

After creating your change to gem5, you can post a review to git
via a pull request at: https://github.com/gem5/gem5/pulls/. Before being able to
submit your code to the mainline of gem5, the code is reviewed by others in the
community. Additionally, the maintainer for that part of the code must sign off
on it.

Cloning the gem5 repo to contribute
===================================

If you plan on contributing, it is strongly encouraged for you to clone the
repository directly, and checkout the `develop` branch from our git instance
at https://github.com/gem5/gem5/.

To clone the gem5 repository:

```
 git clone https://github.com/gem5/gem5/
```

By default, the stable branch is checked out. The stable branch contains the
latest released version of gem5. To obtain code still under-development (and
which contributions can be made):

```
cd gem5
git checkout --track origin/develop
```

Changes should be made to this develop branch. Changes to the stable branch
will be blocked. Once a change on the develop branch is properly incorporated
into the gem5 repo it will be merged into the stable branch upon the next
release of gem5. New releases of gem5 occur three times a year. Ergo, changes
made to the develop branch should appear on the stable branch within three to
four months as part of a stable release.

Other gem5 repositories
-----------------------

There are a few repositories other than the main gem5 development repository.

 * public/m5threads: The code for a pthreads implementation that works with
   gem5's syscall emulation mode.
 * public/gem5-resources: Resources to enable computer architecture research
   with gem5. See the README.md file in the gem5-resources repository for more
   information.
 * public/gem5-website: The gem5.org website source. See the README.md file in
   the gem5-website repository for more information.

Making changes to gem5
======================

It is strongly encouraged to use git branches when making changes to gem5.
Additionally, keeping changes small and concise and only have a single logical
change per commit.

Unlike our previous flow with Mercurial and patch queues, when using git, you
will be committing changes to your local branch. By using separate branches in
git, you will be able to pull in and merge changes from mainline and simply
keep up with upstream changes.

We use a rebase-always model for contributions to the develop branch of gem5.
In this model, the changes are rebased on top of the tip of develop instead of
merged. This means that to contribute, you will have to frequently rebase any
feature branches on top of develop. If you see a "merge conflict" in gerrit, it
can often be solved with a simple rebase. To find out more information about
rebasing and git, see the [git book].

[git book]: https://git-scm.com/book/en/v2/Git-Branching-Rebasing


Setting up pre-commit
---------------------

To help ensure the gem5 style guide is maintained, we use [pre-commit](
https://pre-commit.com) to run checks on changes to be contributed.

To setup pre-commit, run the following in your gem5 directory to install the
pre-commit and commit message hooks.

```sh
pip install pre-commit
pre-commit install -t pre-commit -t commit-msg
```

The hooks are also automatically installed when gem5 is compiled.

When you run a `git commit` command the pre-commit hook will run checks on your
committed code. The commit will be blocked if a check fails.

The same checks are run as part of github actions CI tests (those required to obtain
a Verified label, necessary for a change to be accepted to the develop branch).
Therefore setting up pre-commit in your local gem5 development environment is
recommended.

You can automatically format files to pass the pre-commit tests by running:

```sh
pre-commit run --files <files to format>
```

Requirements for change descriptions
------------------------------------
To help reviewers and future contributors more easily understand and track
changes, we require all change descriptions be strictly formatted.

A canonical commit message consists of three parts:
 * A short summary line describing the change. This line starts with one or
   more keywords (found in the MAINTAINERS file) separated by commas followed
   by a colon and a description of the change. This short description is
   written in the imperative mood, and should say what happens when the patch
   is applied. Keep it short and simple. Write it in sentence case preferably
   not ending in a period. This line should be no more than 65 characters long
   since version control systems usually add a prefix that causes line-wrapping
   for longer lines.
 * (Optional, but highly recommended) A detailed description. This describes
   what you have done and why. If the change isn't obvious, you might want to
   motivate why it is needed. Lines need to be wrapped to 72 characters or
   less. Leave a blank line between the first short summary line and this
   detailed description.
 * Tags describing patch metadata. You are highly recommended to use
   tags to acknowledge reviewers for their work.

Tags are an optional mechanism to store additional metadata about a patch and
acknowledge people who reported a bug or reviewed that patch. Tags are
generally appended to the end of the commit message in the order they happen.
We currently use the following tags:
 * Signed-off-by: Added by the author and the submitter (if different).
   This tag is a statement saying that you believe the patch to be correct and
   have the right to submit the patch according to the license in the affected
   files. Similarly, if you commit someone else's patch, this tells the rest
   of the world that you have have the right to forward it to the main
   repository. If you need to make any changes at all to submit the change,
   these should be described within hard brackets just before your
   Signed-off-by tag. By adding this line, the contributor certifies the
   contribution is made under the terms of the Developer Certificate of Origin
   (DCO) [https://developercertificate.org/].
 * Reviewed-by: Used to acknowledge patch reviewers. It's generally considered
   good form to add these. Added automatically.
 * Reported-by: Used to acknowledge someone for finding and reporting a bug.
 * Reviewed-on: Link to the review request corresponding to this patch. Added
   automatically.
 * Change-Id: Used by Gerrit to track changes across rebases. Added
   automatically with a commit hook by git.
 * Tested-by: Used to acknowledge people who tested a patch. Sometimes added
   automatically by review systems that integrate with CI systems.
 * Issue-On: Used to link a commit to an issue in gem5's [issue tracker]. The
   format should be https://gem5.atlassian.net/browse/GEM5-<NUMBER>

[issue tracker]: https://gem5.atlassian.net/

Other than the "Signed-off-by", "Issue-On", "Reported-by", and "Tested-by"
tags, you generally don't need to add these manually as they are added
automatically by Gerrit.

It is encouraged for the author of the patch and the submitter to add a
Signed-off-by tag to the commit message. By adding this line, the contributor
certifies the contribution is made under the terms of the Developer Certificate
of Origin (DCO) [https://developercertificate.org/].

If your change relates to a [Jira Issue](https://gem5.atlassian.net), it is
advised that you provide a link to the issue in the commit message (or messages
if the Jira Issue relates to multiple commits). Though optional, doing this
can help reviewers understand the context of a change.

It is imperative that you use your real name and your real email address in
both tags and in the author field of the changeset.

For significant changes, authors are encouraged to add copyright information
and their names at the beginning of the file. The main purpose of the author
names on the file is to track who is most knowledgeable about the file (e.g.,
who has contributed a significant amount of code to the file). The
`util/update-copyright.py` helper script can help to keep your copyright dates
up-to-date when you make further changes to files which already have your
copyright but with older dates.

Note: If you do not follow these guidelines, the github actions will
automatically reject your patch.
If this happens, update your changeset descriptions to match the required style
and resubmit. The following is a useful git command to update the most recent
commit (HEAD).

```
 git commit --amend
```

Running tests
=============

Before posting a change to the code review site, you should always run the
quick tests!
See TESTING.md for more information.

Posting a review
================

If you have not signed up for an account on the github
(https://github.com/), you first have to create an account.

Setting up an account
---------------------
 1. Go to https://github.com/
 2. Click "Sign up" in the upper right corner.

Submitting a change
-------------------

In github, to submit a review request, you can simply push your git commits to
a special named branch. For more information on git push see
https://git-scm.com/docs/git-push.

Push changes to GitHub
----------------------------
1. Fork the gem5 repository on GitHub from https://github.com/gem5/gem5/.
2. Create a new branch in your forked repository for your feature or bug fix.
3. Commit your changes to the new branch.
4. Push the branch to your forked repository.
5. Open a pull request from your branch in your forked repository to the main gem5 repository.

We will continue to use the “develop” branch for development, so please ensure your pull requests are for the gem5 develop branch. Pull requests to the stable branch will be blocked.

Branches
========

By default, contributions to gem5 should be made on the develop branch. The
stable branch is maintained as a stable release branch (i.e., it can be pulled
to obtain the latest official release of gem5). Creation of additional branches
is generally discouraged due to their tendency to bloat git repositories with
abandoned code.

Reviewing patches
=================

Reviewing patches is done on our github instance at
https://github.com/gem5/gem5/pulls/.

After logging in with your GitHub account, you will be able to comment, review,
and push your own patches as well as review others' patches. All gem5 users are
encouraged to review patches. The only requirement to review patches is to be
polite and respectful of others.

There are multiple labels in Gerrit that can be applied to each review detailed
below.
 * Code-review: This is used by any gem5 user to review patches. When reviewing
   a patch you can give it a score of -2 to +2 with the following semantics.
   * -2: This blocks the patch. You believe that this patch should never be
     committed. This label should be very rarely used.
   * -1: You would prefer this is not merged as is
   * 0: No score
   * +1: This patch seems good, but you aren't 100% confident that it should be
     pushed.
   * +2: This is a good patch and should be pushed as is.
 * Maintainer: Currently only PMC members are maintainers. At least one
   maintainer must review your patch and give it a +1 before it can be merged.
 * Verified: This is automatically generated from the continuous integrated
   (CI) tests. Each patch must receive at least a +1 from the CI tests before
   the patch can be merged. The patch will receive a +1 if gem5 builds and
   runs, and it will receive a +2 if the stats match.
 * Style-Check: This is automatically generated and tests the patch against the
   gem5 code style
   (http://www.gem5.org/documentation/general_docs/development/coding_style/).
   The patch must receive a +1 from the style checker to be pushed.

Note: Whenever the patch creator updates the patch all reviewers must re-review
the patch. There is no longer a "Fix it, then Ship It" option.

Once you have received reviews for your patch, you will likely need to make
changes. To do this, you should update the original git changeset. Then, you
can simply push the changeset again to the same Gerrit branch to update the
review request.

```
 git push origin HEAD:refs/for/develop
```

Committing changes
==================

Each patch must meet the following criteria to be merged:
 * At least one review with +2
 * At least one maintainer with +1
 * At least +1 from the CI tests (gem5 must build and run)
 * At least +1 from the style checker

Once a patch meets the above criteria, the submitter of the patch will be able
to merge the patch by pressing the "Submit" button on Gerrit. When the patch is
submitted, it is merged into the public gem5 branch.

Review moderation and guidelines
--------------------------------

Once a change is submitted, reviewers shall review the change. This may require
several iterations before a merge. Comments from reviewers may include
questions, and requests for alterations to the change prior to merging. The
overarching philosophy in managing this process is that there should be
politeness and clear communication between all parties at all times, and,
whenever possible, permission should be asked before doing anything that may
inconvenience another party. Included below are some guidelines we expect
contributors and reviewers to follow.

 * In all forms of communication, contributors and reviewers must be polite.
   Comments seen as being needlessly hostile or dismissive will not be
   tolerated.
 * Change contributors should respond to, or act upon, each item of feedback
   given by reviewers. If there is disagreement with a piece of
   feedback, a sufficiently detailed reason for this disagreement should
   be given. Polite discussion, and sharing of information and expertise
   is strongly encouraged.
 * Contributors are advised to assign reviewers when submitting a change.
   Anyone who contributes to gem5 can be assigned as a reviewer. However,
   all changes must be accepted by at least one maintainer prior to a
   merge, ergo assigning of at least one maintainer as a reviewer is
   strongly recommended. Please see MAINTAINERS for a breakdown of
   gem5 maintainers and which components they claim responsibility for.
   Maintainers should be chosen based on which components the change is
   targeting. Assigning of reviewers is not strictly enforced, though not
   assigning reviewers may slow the time in which a change is reviewed.
 * If a contributor posts a change and does not receive any reviews after two
   working days (excluding regional holidays), it is acceptable to "prod"
   reviewers. This can be done by adding a reply to the changeset review
   (e.g., "Would it be possible for someone to review my change?"). If the
   contributor has yet to assign reviewers, they are strongly advised to do so.
   Reviewers will get notified when assigned to referee a change.
 * By default, the original contributor is assumed to own a change. I.e.,
   they are assumed to be the sole party to submit patchsets. If someone
   other than the original contributor wishes to submit patchsets to a
   change on the original contributor's behalf, they should first ask
   permission. If two working days pass without a response, a patchset may be
   submitted without permission. Permission does not need to be asked to submit
   a patchset consisting of minor, inoffensive, changes such a typo and format
   fixes.
 * Once a change is ready to merge, it enters a "Ready to Submit" state. The
   original contributor should  merge their change at this point, assuming they
   are content with the commit in its present form. After two working days, a
   reviewer may message a contributor to remind them of the change being in a
   "Ready to Submit" state and ask if they can merge the change on the
   contributors behalf. If a further two working days elapse without a
   response, the reviewer may merge without permission. A contributor may keep
   a change open for whatever reason though this should be communicated to the
   reviewer when asked.
 * After a month of inactivity from a contributor on an active change, a
   reviewer may post a message on the change reminding the submitter, and
   anyone else watching the change, of its active status and ask if they are
   still interested in eventually merging the change. After two weeks of no
   response the reviewer reserves the right to abandon the change under the
   assumption there is no longer interest.
 * The final arbiter in any dispute between reviewers and/or contributors
   is the PMC (PMC members are highlighted in MAINTAINERS). Disputes requiring
   intervention by the PMC are undesirable. Attempts should be made to resolve
   disagreements via respectful and polite discourse before being escalated to
   this level.

Releases
========

gem5 releases occur 3 times per year. The procedure for releasing gem5 is as
follows:

1. Developers will be notified, via the gem5-dev mailing list, that a new
release of gem5 will occur. This should be no sooner than 2 weeks prior to the
creation of the staging branch (the first step in releasing a new version of
gem5). This gives time for developers to ensure their changes for the next
release are submitted to the develop branch.
2. When a release is ready, a new staging branch shall be created by a project
maintainer, from develop, with the name "release-staging-{VERSION}". The
gem5-dev mailing list will be notified that the staging branch will be merged
into the stable branch after two weeks, thus marking the new release.
3. The staging branch will have the full suite of gem5 tests run on it to
ensure all tests pass and the to-be-released code is in a decent state.
4. If a user submits a changeset to the staging branch, it will be considered
and undergo the standard github review process. However, only alterations that
cannot wait until the following release will be accepted for submission into
the branch (i.e., submissions to the staging branch for "last minute"
inclusions to the release should be of a high priority, such as a critical bug
fix). The project maintainers will use their discretion in deciding whether a
change may be submitted directly to the staging branch. All other submissions
to gem5 will continue to be made to the develop branch. Patches submitted
into the staging branch do not need to be re-added to the develop branch.
5. Once signed off by members of the PMC the staging branch shall be merged
into the stable and develop branch. The staging branch will then be deleted.
6. The stable branch shall be tagged with the correct version number for that
release. gem5 conforms to a "v{YY}.{MAJOR}.{MINOR}.{HOTFIX}" versioning system.
E.g., the first major release of 2022 will be "v22.0.0.0", followed by
"v22.1.0.0". All the releases (with the exception of hotfixes) are considered
major releases. For the meantime, there are no minor releases though we keep
the minor release numbers in case this policy changes in the future.
7. The gem5-dev and gem5-user mailing lists shall be notified of the new gem5
release.

Hotfixes
--------

There may be circumstances in which a change to gem5 is deemed critical and
cannot wait for an official release (e.g., a high-priority bug fix). In these
circumstances a hotfix shall be made.

First, if a developer suspects a hotfix may be necessary then the issue
should be discussed on the gem5-dev mailing list. The community will decide
whether the issue is worthy of a hotfix, and the final decision should be
made by members of the PMC if there is no consensus. Assuming the hotfix is
permitted, the following steps will be taken:

1. A new branch with the prefix "hotfix-" will be created from the stable
branch. Only gem5 maintainers can create branches. If a non-maintainer requires
the creation of a hotfix branch then they should contact a gem5 maintainer.
2. The change shall be submitted to the hotfix branch via github. Full review,
as with any other change, will be required.
3. Once fully submitted, the hotfix branch shall be merged into both the
develop and the stable branch by a gem5 maintainer.
4. The stable branch will be tagged with the new version number; the same as
the last but with an incremented hotfix number (e.g., "v20.2.0.0" would
transition to "v20.2.0.1").
4. The hotfix branch will then be deleted.
5. The gem5-dev and the gem5-user mailing lists shall be notified of this
hotfix.
