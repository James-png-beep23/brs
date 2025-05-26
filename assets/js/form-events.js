export const ShareOwnerShip = {
  mounted() {
    this.el.addEventListener("click", (e) => {
      // Prevent default button behavior
      e.preventDefault();

      // Gather form data
      const share_holder_id = document.getElementById("share_holder_id").value;
      const indirect_share = document.getElementById("indirect_share").value;

      // Send data to LiveView
      this.pushEventTo(this.el, "add-share-ownership", {
        share_holder_id: share_holder_id,
        indirect_share: indirect_share,
      });
    });
  },
};

export const ShareVoteRights = {
  mounted() {
    this.el.addEventListener("click", (e) => {
      // Prevent default button behavior
      e.preventDefault();

      // Gather form data
      const vote_holder = document.getElementById("vote-holder").value;
      const indirect_votes = document.getElementById("indirect-votes").value;

      // Send data to LiveView
      this.pushEventTo(this.el, "add-voting-rights", {
        vote_holder: vote_holder,
        indirect_votes: indirect_votes,
      });
    });
  },
};

export const AllocateShares = {
  mounted() {
    this.el.addEventListener("click", (e) => {
      e.preventDefault();
      let category = this.el.dataset.category;
      let shares = document.getElementById("shares-" + this.el.dataset.index).value;

      this.pushEventTo(this.el, "issue-shares", {
        shares: shares,
        category: category
      });
    });
  },
};