# Latex-Online container
#
# VERSION       1

# Use the node:18-bullseye-slim base image
FROM node:18-bullseye-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    biber \
    cm-super \
    fontconfig \
    git \
    python3 \
    texlive-bibtex-extra \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-publishers \
    texlive-science \
    texlive-xetex \
    ca-certificates \
    && apt-get clean

# Add xindy-2.2 instead of makeindex.
ADD ./packages/xindy-2.2-rc2-linux.tar.gz /opt
ENV PATH="/opt/xindy-2.2/bin:${PATH}"

# Copy the entrypoint script
COPY ./util/docker-entrypoint.sh /

# Expose port 2700
EXPOSE 2700

# Set the default command to run the entrypoint script
CMD ["./docker-entrypoint.sh"]
